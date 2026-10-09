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
    /// The commands needed to run `test` from `src` using `work` as scratch space.
    /// Pure, so it can also render portable commands for reproducers.
    pub fn plan(&self, test: &TestCase, src: &Path, work: &Path) -> Vec<Step> {
        let src = src.to_string_lossy().into_owned();
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
                args.extend(self.flags.iter().cloned());
                args.extend(test.flags(self.profile.name()));
                args.push(src);
                steps.push(Step { program: self.exe.clone(), args });
                if simulate {
                    steps.push(Step { program: path_str(&obj.join("Vtop")), args: vec![] });
                }
            }
            Profile::Icarus => {
                let vvp_file = path_str(&work.join("sim.vvp"));
                args.extend(["-g2012", "-s", "top", "-o"].map(String::from));
                args.push(vvp_file.clone());
                args.extend(self.flags.iter().cloned());
                args.extend(test.flags(self.profile.name()));
                args.push(src);
                steps.push(Step { program: self.exe.clone(), args });
                if simulate {
                    steps.push(Step { program: self.vvp(), args: vec!["-n".into(), vvp_file] });
                }
            }
            Profile::Generic => {
                args.extend(self.flags.iter().cloned());
                args.extend(test.flags(self.profile.name()));
                args.push(src);
                steps.push(Step { program: self.exe.clone(), args });
            }
        }
        steps
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
    let child = Command::new(&step.program)
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
    for step in tool.plan(test, &test.path, work) {
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
        if !output.lines().any(|l| l.trim() == "PASS") {
            return (Status::Fail, "simulation finished without printing PASS".into());
        }
    }
    (Status::Pass, "ok".into())
}
