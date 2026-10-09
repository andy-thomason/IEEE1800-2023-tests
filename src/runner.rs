//! Turns a test into tool invocations, runs them and judges the result.

use crate::test_case::{TestCase, TestType};
use std::io::Read;
use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};
use std::time::{Duration, Instant};
use wait_timeout::ChildExt;

#[derive(Clone, Copy, Debug, PartialEq, Eq, clap::ValueEnum)]
pub enum Profile {
    /// `verilator --binary`, then run `<work>/obj/Vtop`.
    Verilator,
    /// `iverilog -g2012`, then run `vvp`.
    Icarus,
    /// `<exe> <flags> <file>`; one step whose output is judged directly.
    Generic,
}

impl Profile {
    pub fn detect(exe: &str) -> Profile {
        let stem = Path::new(exe)
            .file_stem()
            .map(|s| s.to_string_lossy().to_lowercase())
            .unwrap_or_default();
        if stem.contains("verilator") {
            Profile::Verilator
        } else if stem.contains("iverilog") || stem.contains("icarus") {
            Profile::Icarus
        } else {
            Profile::Generic
        }
    }

    pub fn name(self) -> &'static str {
        match self {
            Profile::Verilator => "verilator",
            Profile::Icarus => "icarus",
            Profile::Generic => "generic",
        }
    }
}

#[derive(Clone, Debug)]
pub struct Step {
    pub program: String,
    pub args: Vec<String>,
    /// Working directory for the command, if not the current one.
    pub cwd: Option<PathBuf>,
}

impl Step {
    /// A copy-pasteable POSIX shell rendering of the command.
    pub fn shell(&self) -> String {
        std::iter::once(&self.program)
            .chain(&self.args)
            .map(|a| shell_quote(a))
            .collect::<Vec<_>>()
            .join(" ")
    }
}

fn shell_quote(s: &str) -> String {
    let safe = |c: char| c.is_ascii_alphanumeric() || "-_./=+:,@%".contains(c);
    if !s.is_empty() && s.chars().all(safe) {
        s.to_string()
    } else {
        format!("'{}'", s.replace('\'', r"'\''"))
    }
}

pub struct Tool {
    pub exe: String,
    pub profile: Profile,
    pub flags: Vec<String>,
}

impl Tool {
    /// The commands needed to run `test` with its sources in `dir`, using `work`
    /// as scratch space. Pure, so it can also render portable commands for
    /// reproducers.
    pub fn plan(&self, test: &TestCase, dir: &Path, work: &Path) -> Vec<Step> {
        let srcs: Vec<String> = test.sources().iter().map(|s| path_str(&dir.join(s))).collect();
        let inc_dir = if dir.as_os_str().is_empty() { ".".to_string() } else { path_str(dir) };
        let simulate = test.test_type == TestType::Simulation;
        let mut args: Vec<String> = Vec::new();
        let mut steps = Vec::new();
        match self.profile {
            Profile::Verilator => {
                let obj = work.join("obj");
                if simulate {
                    args.extend(["--binary".into(), "-Mdir".into(), path_str(&obj)]);
                } else {
                    args.push("--lint-only".into());
                }
                // Lint warnings are not conformance failures.
                args.extend(["-Wno-fatal".into(), "--top-module".into(), "top".into()]);
                args.push(format!("-I{inc_dir}"));
                args.extend(self.flags.iter().cloned());
                args.extend(test.flags(self.profile.name()));
                args.extend(srcs);
                // Verilator compiles DPI-C sources given on its command line.
                args.extend(test.dpi.iter().map(|c| path_str(&dir.join(c))));
                steps.push(Step { program: self.exe.clone(), args, cwd: None });
                if simulate {
                    steps.push(Step { program: path_str(&obj.join("Vtop")), args: test.plusargs(), cwd: None });
                }
            }
            Profile::Icarus => {
                // Icarus has no DPI-C support, so :dpi: sources are not passed;
                // the import itself reports the gap.
                let vvp_file = path_str(&work.join("sim.vvp"));
                args.extend(["-g2012", "-s", "top", "-o"].map(String::from));
                args.push(vvp_file.clone());
                args.push(format!("-I{inc_dir}"));
                args.extend(self.flags.iter().cloned());
                args.extend(test.flags(self.profile.name()));
                args.extend(srcs);
                steps.push(Step { program: self.exe.clone(), args, cwd: None });
                if simulate {
                    steps.push(Step {
                        program: self.vvp(),
                        args: [vec!["-n".into(), vvp_file], test.plusargs()].concat(),
                        cwd: None,
                    });
                }
            }
            Profile::Generic => {
                args.extend(self.flags.iter().cloned());
                args.extend(test.flags(self.profile.name()));
                args.extend(srcs);
                args.extend(test.dpi.iter().map(|c| path_str(&dir.join(c))));
                steps.push(Step { program: self.exe.clone(), args, cwd: None });
            }
        }
        steps
    }

    /// The executable as an absolute path if it names a file relative to the
    /// current directory; bare names are left for PATH lookup.
    fn exe_path(&self) -> String {
        let p = Path::new(&self.exe);
        if p.components().count() > 1 {
            std::fs::canonicalize(p).map(|a| path_str(&a)).unwrap_or_else(|_| self.exe.clone())
        } else {
            self.exe.clone()
        }
    }

    /// `vvp` from the same directory as `iverilog` if present, else from PATH.
    fn vvp(&self) -> String {
        let exe = Path::new(&self.exe);
        match exe.parent() {
            Some(dir) if !dir.as_os_str().is_empty() && dir.join("vvp").exists() => path_str(&dir.join("vvp")),
            _ => "vvp".into(),
        }
    }
}

fn path_str(p: &Path) -> String {
    p.to_string_lossy().into_owned()
}

#[derive(Debug)]
pub struct StepResult {
    pub step: Step,
    /// `None` if killed by a signal or by the timeout.
    pub exit_code: Option<i32>,
    pub timed_out: bool,
    pub spawn_error: Option<String>,
    pub stdout: String,
    pub stderr: String,
    pub duration: Duration,
}

impl StepResult {
    pub fn succeeded(&self) -> bool {
        self.exit_code == Some(0)
    }

    /// The tool ran to completion and reported failure in the normal way.
    pub fn exited_with_error(&self) -> bool {
        matches!(self.exit_code, Some(c) if c != 0)
    }
}

pub fn run_step(step: &Step, timeout: Duration) -> StepResult {
    let start = Instant::now();
    let mut result = StepResult {
        step: step.clone(),
        exit_code: None,
        timed_out: false,
        spawn_error: None,
        stdout: String::new(),
        stderr: String::new(),
        duration: Duration::ZERO,
    };
    let mut command = Command::new(&step.program);
    if let Some(dir) = &step.cwd {
        command.current_dir(dir);
    }
    let child = command
        .args(&step.args)
        .stdin(Stdio::null())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn();
    let mut child = match child {
        Ok(c) => c,
        Err(e) => {
            result.spawn_error = Some(format!("failed to start `{}`: {e}", step.program));
            return result;
        }
    };
    // Drain the pipes on threads so a chatty tool cannot block on a full pipe.
    let drain = |r: Option<Box<dyn Read + Send>>| {
        std::thread::spawn(move || {
            let mut buf = Vec::new();
            if let Some(mut r) = r {
                let _ = r.read_to_end(&mut buf);
            }
            String::from_utf8_lossy(&buf).into_owned()
        })
    };
    let out = drain(child.stdout.take().map(|r| Box::new(r) as Box<dyn Read + Send>));
    let err = drain(child.stderr.take().map(|r| Box::new(r) as Box<dyn Read + Send>));
    match child.wait_timeout(timeout) {
        Ok(Some(status)) => result.exit_code = status.code(),
        Ok(None) => {
            result.timed_out = true;
            let _ = child.kill();
            let _ = child.wait();
        }
        Err(e) => result.spawn_error = Some(format!("wait failed: {e}")),
    }
    result.stdout = out.join().unwrap_or_default();
    result.stderr = err.join().unwrap_or_default();
    result.duration = start.elapsed();
    result
}

#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord)]
pub enum Status {
    Pass,
    Fail,
}

pub struct Outcome {
    pub status: Status,
    pub reason: String,
    pub steps: Vec<StepResult>,
    pub work: PathBuf,
}

/// Runs the steps in order, stopping at the first that does not succeed.
pub fn run_test(tool: &Tool, test: &TestCase, work: &Path, timeout: Duration) -> Outcome {
    let _ = std::fs::remove_dir_all(work);
    let mut steps = Vec::new();
    if let Err(e) = std::fs::create_dir_all(work) {
        return Outcome {
            status: Status::Fail,
            reason: format!("cannot create work dir {}: {e}", work.display()),
            steps,
            work: work.to_path_buf(),
        };
    }
    // Tools run inside the work directory so files a test writes stay there;
    // paths given to them must therefore be absolute.
    let abs = |p: &Path| std::fs::canonicalize(p).unwrap_or_else(|_| p.to_path_buf());
    let work_abs = abs(work);
    for name in &test.data {
        if let Err(e) = std::fs::copy(test.dir().join(name), work_abs.join(name)) {
            return Outcome {
                status: Status::Fail,
                reason: format!("cannot copy data file {name}: {e}"),
                steps,
                work: work.to_path_buf(),
            };
        }
    }
    let tool_abs = Tool { exe: tool.exe_path(), profile: tool.profile, flags: tool.flags.clone() };
    for mut step in tool_abs.plan(test, &abs(test.dir()), &work_abs) {
        step.cwd = Some(work_abs.clone());
        let r = run_step(&step, timeout);
        let ok = r.succeeded();
        steps.push(r);
        if !ok {
            break;
        }
    }
    let (status, reason) = judge(test, &steps, timeout);
    Outcome { status, reason, steps, work: work.to_path_buf() }
}

fn judge(test: &TestCase, steps: &[StepResult], timeout: Duration) -> (Status, String) {
    let last = steps.last().expect("at least one step");
    if let Some(e) = &last.spawn_error {
        return (Status::Fail, e.clone());
    }
    if last.timed_out {
        return (Status::Fail, format!("`{}` timed out after {}s", last.step.program, timeout.as_secs()));
    }
    if test.should_fail() {
        return if last.exited_with_error() {
            (Status::Pass, "rejected as required".into())
        } else if last.exit_code.is_none() {
            (Status::Fail, format!("`{}` crashed (killed by a signal) instead of reporting an error", last.step.program))
        } else {
            (Status::Fail, "accepted code that the standard requires to be an error".into())
        };
    }
    if !last.succeeded() {
        return match last.exit_code {
            Some(code) => (Status::Fail, format!("`{}` exited with code {code}", last.step.program)),
            None => (Status::Fail, format!("`{}` crashed (killed by a signal)", last.step.program)),
        };
    }
    if test.test_type == TestType::Simulation {
        let output = format!("{}\n{}", last.stdout, last.stderr);
        if let Some(line) = output.lines().find(|l| l.contains("FAIL")) {
            return (Status::Fail, format!("self-check failed: {}", line.trim()));
        }
        if !test.expect.is_empty() {
            let mut lines = output.lines().map(str::trim);
            for want in &test.expect {
                if !lines.any(|l| l == want) {
                    return (Status::Fail, format!("expected output line not found (in order): {want}"));
                }
            }
        } else if !output.lines().any(|l| l.trim() == "PASS") {
            return (Status::Fail, "simulation finished without printing PASS".into());
        }
    }
    (Status::Pass, "ok".into())
}
