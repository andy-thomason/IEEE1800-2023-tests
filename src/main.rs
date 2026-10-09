//! test1800: runs IEEE 1800-2023 conformance tests against a SystemVerilog tool.

mod report;
mod runner;
mod test_case;

use clap::Parser;
use runner::{Outcome, Profile, Status, Tool};
use std::path::{Path, PathBuf};
use std::process::ExitCode;
use std::sync::Mutex;
use std::time::Duration;
use test_case::TestCase;

/// Run IEEE 1800-2023 conformance tests against a simulator and write a
/// Markdown reproducer for every failure.
///
/// Example: test1800 verilator -- -Wno-WIDTH
#[derive(Parser)]
#[command(version)]
struct Cli {
    /// Tool to test, e.g. `verilator` or `iverilog` (name or path).
    #[arg(required_unless_present = "list")]
    exe: Option<String>,

    /// Extra flags passed to the tool, after `--`.
    #[arg(last = true)]
    flags: Vec<String>,

    /// Extra flags as one string, e.g. -F "-DFOO -Wall". Added before the `--` flags.
    #[arg(short = 'F', long = "flags", value_name = "FLAGS", allow_hyphen_values = true)]
    flag_string: Vec<String>,

    /// How to drive the tool. Detected from the executable name by default.
    #[arg(short, long, value_enum)]
    profile: Option<Profile>,

    /// Directory containing the .sv tests.
    #[arg(short, long, default_value = "tests")]
    tests: PathBuf,

    /// Output directory [default: results/<profile>].
    #[arg(short, long)]
    out: Option<PathBuf>,

    /// Only run tests whose name or section contains this text (repeatable).
    #[arg(short = 'k', long)]
    filter: Vec<String>,

    /// Parallel jobs [default: number of CPUs].
    #[arg(short, long)]
    jobs: Option<usize>,

    /// Per-step timeout in seconds.
    #[arg(long, default_value_t = 120)]
    timeout: u64,

    /// Keep work directories of passing tests.
    #[arg(long)]
    keep_work: bool,

    /// List the selected tests and exit.
    #[arg(long)]
    list: bool,
}

fn main() -> ExitCode {
    let cli = Cli::parse();
    match run(cli) {
        Ok(true) => ExitCode::SUCCESS,
        Ok(false) => ExitCode::from(1),
        Err(e) => {
            eprintln!("test1800: {e}");
            ExitCode::from(2)
        }
    }
}

/// Returns Ok(true) if every test passed.
fn run(cli: Cli) -> Result<bool, String> {
    let paths = test_case::discover(&cli.tests).map_err(|e| format!("reading {}: {e}", cli.tests.display()))?;
    let mut tests = Vec::new();
    let mut invalid = Vec::new();
    for path in paths {
        match test_case::load(&cli.tests, &path) {
            Ok(t) => tests.push(t),
            Err(e) => invalid.push((path.display().to_string(), e)),
        }
    }
    tests.retain(|t| cli.filter.is_empty() || cli.filter.iter().any(|f| t.name.contains(f) || t.section.contains(f)));
    if cli.list {
        for t in &tests {
            println!("§{:<12} {}", t.section.split_whitespace().next().unwrap_or(""), t.name);
        }
        return Ok(true);
    }
    let exe = cli.exe.expect("clap requires exe unless --list");
    let profile = cli.profile.unwrap_or_else(|| Profile::detect(&exe));
    let mut flags: Vec<String> = cli.flag_string.iter().flat_map(|s| test_case::split_flags(s)).collect();
    flags.extend(cli.flags);
    let tool = Tool { exe, profile, flags };
    for (path, err) in &invalid {
        eprintln!("[INVALID] {path}: {err}");
    }
    if tests.is_empty() {
        return Err(format!("no tests selected in {}", cli.tests.display()));
    }

    let out = cli.out.unwrap_or_else(|| Path::new("results").join(profile.name()));
    let failures_dir = out.join("failures");
    // Stale reproducers would be misleading, so start clean.
    let _ = std::fs::remove_dir_all(&failures_dir);
    std::fs::create_dir_all(&failures_dir).map_err(|e| format!("creating {}: {e}", failures_dir.display()))?;
    let version = tool_version(&tool)?;
    eprintln!(
        "test1800: {} tests, {} ({}{})",
        tests.len(),
        tool.exe,
        profile.name(),
        if version.is_empty() { String::new() } else { format!(", {version}") }
    );

    let jobs = cli.jobs.unwrap_or_else(|| std::thread::available_parallelism().map_or(1, |n| n.get())).max(1);
    let queue = Mutex::new(tests.into_iter().enumerate());
    let done = Mutex::new(Vec::new());
    std::thread::scope(|s| {
        for _ in 0..jobs {
            s.spawn(|| {
                loop {
                    let Some((i, test)) = queue.lock().unwrap().next() else { break };
                    let work = out.join("work").join(&test.name);
                    let timeout = Duration::from_secs(test.timeout_secs.unwrap_or(cli.timeout));
                    let outcome = runner::run_test(&tool, &test, &work, timeout);
                    if outcome.status == Status::Pass {
                        println!("[PASS] {}", test.name);
                        if !cli.keep_work {
                            let _ = std::fs::remove_dir_all(&work);
                        }
                    } else {
                        println!("[FAIL] {}: {}", test.name, outcome.reason);
                        let md = report::reproducer(&tool, &version, &test, &outcome);
                        let path = failures_dir.join(report::repro_file_name(&test));
                        if let Err(e) = std::fs::write(&path, md) {
                            eprintln!("test1800: writing {}: {e}", path.display());
                        }
                    }
                    done.lock().unwrap().push((i, test, outcome));
                }
            });
        }
    });
    let _ = std::fs::remove_dir(out.join("work"));

    let mut results: Vec<(usize, TestCase, Outcome)> = done.into_inner().unwrap();
    results.sort_by_key(|(i, ..)| *i);
    let results: Vec<(TestCase, Outcome)> = results.into_iter().map(|(_, t, o)| (t, o)).collect();
    let summary_path = out.join("summary.md");
    std::fs::write(&summary_path, report::summary(&tool, &version, &results, &invalid))
        .map_err(|e| format!("writing {}: {e}", summary_path.display()))?;

    let failed = results.iter().filter(|(_, o)| o.status != Status::Pass).count();
    eprintln!(
        "test1800: {} passed, {failed} failed, {} invalid; see {}",
        results.len() - failed,
        invalid.len(),
        summary_path.display()
    );
    Ok(failed == 0 && invalid.is_empty())
}

/// First line of the tool's version output, or empty if it has none.
/// Also checks the executable can be started at all.
fn tool_version(tool: &Tool) -> Result<String, String> {
    let arg = match tool.profile {
        Profile::Icarus => "-V",
        _ => "--version",
    };
    let step = runner::Step { program: tool.exe.clone(), args: vec![arg.into()], cwd: None };
    let r = runner::run_step(&step, Duration::from_secs(10));
    if let Some(e) = r.spawn_error {
        return Err(e);
    }
    Ok(format!("{}\n{}", r.stdout, r.stderr)
        .lines()
        .map(str::trim)
        .find(|l| !l.is_empty())
        .unwrap_or("")
        .to_string())
}
