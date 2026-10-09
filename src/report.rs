//! Markdown output: one reproducer per failure plus a summary table.

use crate::runner::{Outcome, Status, Tool};
use crate::test_case::TestCase;
use std::fmt::Write;
use std::path::Path;

/// Longest tool output kept in a reproducer, per stream.
const MAX_OUTPUT: usize = 8 * 1024;

pub fn repro_file_name(test: &TestCase) -> String {
    format!("{}.md", test.name.replace('/', "__"))
}

/// A reproducer that stands alone: the source, the commands and what went wrong.
pub fn reproducer(tool: &Tool, version: &str, test: &TestCase, outcome: &Outcome) -> String {
    let mut md = String::new();
    let w = &mut md;
    let _ = writeln!(w, "# {}: {}\n", test.name, outcome.reason);
    let _ = writeln!(w, "| | |\n|---|---|");
    let _ = writeln!(w, "| Tool | `{}` ({}) |", tool.exe, tool.profile.name());
    if !version.is_empty() {
        let _ = writeln!(w, "| Version | `{version}` |");
    }
    let _ = writeln!(w, "| Test | `{}` |", test.path.display());
    let _ = writeln!(w, "| Type | {} |", test.test_type);
    let _ = writeln!(w, "| Section | IEEE 1800-2023 §{} |", test.section);
    let expected = match &test.should_fail_because {
        Some(why) => format!("tool reports an error ({why})"),
        None if !test.expect.is_empty() => {
            let lines: Vec<String> = test.expect.iter().map(|l| format!("`{l}`")).collect();
            format!("all steps exit 0 and the output contains, in order: {}", lines.join(", "))
        }
        None if test.test_type == crate::test_case::TestType::Simulation => {
            "all steps exit 0 and the simulation prints `PASS`".into()
        }
        None => format!("{} succeeds", test.test_type),
    };
    let _ = writeln!(w, "| Expected | {} |", expected.replace('\n', " "));
    let _ = writeln!(w, "| Result | {} |\n", outcome.reason.replace('|', "\\|"));

    let _ = writeln!(w, "## Standard\n");
    let _ = writeln!(w, "IEEE 1800-2023 §{}:\n", test.section);
    let _ = writeln!(w, "> {}\n", test.quote);
    if let Some(d) = &test.description {
        let _ = writeln!(w, "{d}\n");
    }

    let _ = writeln!(w, "## Reproduce\n");
    let mut names = test.sources();
    names.extend(test.includes.iter().cloned());
    names.extend(test.dpi.iter().cloned());
    names.extend(test.vpi.iter().cloned());
    names.extend(test.data.iter().cloned());
    let listed = names.iter().map(|n| format!("`{n}`")).collect::<Vec<_>>().join(", ");
    let _ = writeln!(w, "Save the files below ({listed}) in one directory, then run there:\n");
    let _ = writeln!(w, "```sh\nmkdir -p work");
    for step in tool.plan(test, Path::new(""), Path::new("work")) {
        let _ = writeln!(w, "{}", step.shell());
    }
    let _ = writeln!(w, "```\n");
    for name in &names {
        let text = if *name == test.file_name() {
            test.source.clone()
        } else {
            std::fs::read_to_string(test.dir().join(name)).unwrap_or_else(|e| format!("// cannot read: {e}"))
        };
        let lang = if name.ends_with(".c") || name.ends_with(".cpp") {
            "c"
        } else if name.ends_with(".sv") || name.ends_with(".svh") || name.ends_with(".v") {
            "systemverilog"
        } else {
            "text"
        };
        let _ = writeln!(w, "`{name}`:\n\n```{lang}\n{}\n```\n", text.trim_end());
    }

    let _ = writeln!(w, "## Observed\n");
    let _ = writeln!(w, "Work directory: `{}`\n", outcome.work.display());
    for r in &outcome.steps {
        let _ = writeln!(w, "```sh\n$ {}\n```\n", r.step.shell());
        let status = if let Some(e) = &r.spawn_error {
            e.clone()
        } else if r.timed_out {
            "timed out".into()
        } else {
            match r.exit_code {
                Some(c) => format!("exit code {c}"),
                None => "killed by a signal".into(),
            }
        };
        let _ = writeln!(w, "{status} after {:.2}s\n", r.duration.as_secs_f64());
        for (label, text) in [("stdout", &r.stdout), ("stderr", &r.stderr)] {
            if !text.trim().is_empty() {
                let _ = writeln!(w, "{label}:\n\n```text\n{}\n```\n", truncate(text).trim_end());
            }
        }
    }
    md
}

fn truncate(s: &str) -> String {
    if s.len() <= MAX_OUTPUT {
        return s.to_string();
    }
    let mut end = MAX_OUTPUT;
    while !s.is_char_boundary(end) {
        end -= 1;
    }
    format!("{}\n... ({} bytes truncated)", &s[..end], s.len() - end)
}

pub fn summary(tool: &Tool, version: &str, results: &[(TestCase, Outcome)], invalid: &[(String, String)]) -> String {
    let count = |s: Status| results.iter().filter(|(_, o)| o.status == s).count();
    let mut md = String::new();
    let w = &mut md;
    let _ = writeln!(w, "# IEEE 1800-2023 conformance: `{}`\n", tool.exe);
    if !version.is_empty() {
        let _ = writeln!(w, "Version: `{version}`\n");
    }
    let _ = writeln!(w, "Profile: {}\n", tool.profile.name());
    if !tool.flags.is_empty() {
        let _ = writeln!(w, "Extra flags: `{}`\n", tool.flags.join(" "));
    }
    let _ = writeln!(
        w,
        "**{} passed, {} failed, {} invalid tests** out of {}\n",
        count(Status::Pass),
        count(Status::Fail),
        invalid.len(),
        results.len() + invalid.len()
    );
    let _ = writeln!(w, "| Result | Section | Test | Detail |\n|---|---|---|---|");
    for (test, outcome) in results {
        let (mark, test_cell) = match outcome.status {
            Status::Pass => ("pass", format!("`{}`", test.name)),
            _ => ("**FAIL**", format!("[`{}`](failures/{})", test.name, repro_file_name(test))),
        };
        let _ = writeln!(w, "| {mark} | §{} | {test_cell} | {} |", test.section, outcome.reason.replace('|', "\\|"));
    }
    if !invalid.is_empty() {
        let _ = writeln!(w, "\n## Invalid tests\n");
        for (path, err) in invalid {
            let _ = writeln!(w, "- `{path}`: {err}");
        }
    }
    md
}
