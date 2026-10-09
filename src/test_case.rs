//! Discovery and header parsing for `.sv` test files.
//!
//! Every test starts with a block comment holding `:key: value` metadata:
//!
//! ```text
//! /*
//! :section: 5.7.1 Integer literal constants
//! :quote: An x digit in a hex literal makes four bits unknown.
//!         (lines without a key continue the previous value)
//! :type: simulation          parse | elaboration | simulation (default)
//! :should_fail_because: why the tool must reject this code
//! :flags: -DFOO              extra flags for every tool
//! :flags-verilator: ...      extra flags for one tool profile only
//! :timeout: 30               seconds, overrides --timeout
//! */
//! ```
//!
//! A quote that itself contains a comment terminator writes it as `*\/`.

use std::collections::BTreeMap;
use std::fmt;
use std::fs;
use std::path::{Path, PathBuf};

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum TestType {
    /// The tool only needs to parse the file.
    Parse,
    /// The tool needs to parse and elaborate the design.
    Elaboration,
    /// The design is run and must print `PASS` and no `FAIL`.
    Simulation,
}

impl fmt::Display for TestType {
    fn fmt(&self, f: &mut fmt::Formatter) -> fmt::Result {
        f.write_str(match self {
            TestType::Parse => "parse",
            TestType::Elaboration => "elaboration",
            TestType::Simulation => "simulation",
        })
    }
}

#[derive(Debug)]
pub struct TestCase {
    /// Path relative to the tests directory, without extension.
    pub name: String,
    pub path: PathBuf,
    pub source: String,
    pub section: String,
    pub quote: String,
    pub description: Option<String>,
    pub test_type: TestType,
    pub should_fail_because: Option<String>,
    pub timeout_secs: Option<u64>,
    meta: BTreeMap<String, String>,
}

impl TestCase {
    pub fn should_fail(&self) -> bool {
        self.should_fail_because.is_some()
    }

    /// Flags from `:flags:` followed by `:flags-<profile>:`.
    pub fn flags(&self, profile: &str) -> Vec<String> {
        let mut flags = split_flags(self.meta.get("flags").map_or("", |s| s));
        if let Some(extra) = self.meta.get(&format!("flags-{profile}")) {
            flags.extend(split_flags(extra));
        }
        flags
    }
}

/// Splits on whitespace, honouring single and double quotes.
pub fn split_flags(s: &str) -> Vec<String> {
    let mut out = Vec::new();
    let mut cur = String::new();
    let mut in_word = false;
    let mut quote: Option<char> = None;
    for c in s.chars() {
        match quote {
            Some(q) if c == q => quote = None,
            Some(_) => cur.push(c),
            None if c == '"' || c == '\'' => {
                quote = Some(c);
                in_word = true;
            }
            None if c.is_whitespace() => {
                if in_word {
                    out.push(std::mem::take(&mut cur));
                    in_word = false;
                }
            }
            None => {
                cur.push(c);
                in_word = true;
            }
        }
    }
    if in_word {
        out.push(cur);
    }
    out
}

const KNOWN_KEYS: &[&str] = &[
    "name",
    "section",
    "quote",
    "description",
    "type",
    "should_fail_because",
    "flags",
    "timeout",
];

fn parse_header(source: &str) -> Result<BTreeMap<String, String>, String> {
    let body = source
        .trim_start()
        .strip_prefix("/*")
        .ok_or("file does not start with a /* ... */ metadata header")?;
    let end = body.find("*/").ok_or("unterminated metadata header")?;
    let mut meta: BTreeMap<String, String> = BTreeMap::new();
    let mut current: Option<String> = None;
    for line in body[..end].lines() {
        let trimmed = line.trim();
        let key_value = trimmed
            .strip_prefix(':')
            .and_then(|rest| rest.split_once(':'))
            .filter(|(k, _)| !k.is_empty() && k.chars().all(|c| c.is_ascii_alphanumeric() || c == '_' || c == '-'));
        if let Some((key, value)) = key_value {
            if !KNOWN_KEYS.contains(&key) && !key.starts_with("flags-") {
                return Err(format!("unknown metadata key :{key}:"));
            }
            if meta.insert(key.to_string(), value.trim().to_string()).is_some() {
                return Err(format!("duplicate metadata key :{key}:"));
            }
            current = Some(key.to_string());
        } else if !trimmed.is_empty() {
            let key = current.as_ref().ok_or_else(|| format!("text outside any key: {trimmed}"))?;
            let value = meta.get_mut(key).unwrap();
            if !value.is_empty() {
                value.push(if key == "quote" { ' ' } else { '\n' });
            }
            value.push_str(trimmed);
        }
    }
    for value in meta.values_mut() {
        *value = value.replace("*\\/", "*/");
    }
    Ok(meta)
}

pub fn load(tests_dir: &Path, path: &Path) -> Result<TestCase, String> {
    let source = fs::read_to_string(path).map_err(|e| e.to_string())?;
    let name = path
        .strip_prefix(tests_dir)
        .unwrap_or(path)
        .with_extension("")
        .to_string_lossy()
        .replace('\\', "/");
    let mut meta = parse_header(&source)?;
    let required = |meta: &mut BTreeMap<String, String>, key: &str| {
        meta.remove(key)
            .filter(|v| !v.is_empty())
            .ok_or_else(|| format!("missing required metadata :{key}:"))
    };
    let section = required(&mut meta, "section")?;
    let quote = required(&mut meta, "quote")?;
    let test_type = match meta.remove("type").as_deref() {
        None | Some("simulation") => TestType::Simulation,
        Some("elaboration") => TestType::Elaboration,
        Some("parse") => TestType::Parse,
        Some(other) => return Err(format!("unknown :type: {other}")),
    };
    let timeout_secs = meta
        .remove("timeout")
        .map(|t| t.parse().map_err(|_| format!("bad :timeout: {t}")))
        .transpose()?;
    Ok(TestCase {
        name,
        path: path.to_path_buf(),
        section,
        quote,
        description: meta.remove("description"),
        test_type,
        should_fail_because: meta.remove("should_fail_because"),
        timeout_secs,
        meta,
        source,
    })
}

/// Recursively finds `.sv` files, sorted by path so clause order is preserved.
pub fn discover(dir: &Path) -> std::io::Result<Vec<PathBuf>> {
    let mut out = Vec::new();
    let mut stack = vec![dir.to_path_buf()];
    while let Some(d) = stack.pop() {
        for entry in fs::read_dir(&d)? {
            let path = entry?.path();
            if path.is_dir() {
                stack.push(path);
            } else if path.extension().is_some_and(|e| e == "sv") {
                out.push(path);
            }
        }
    }
    out.sort();
    Ok(out)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn header_continuation_and_flags() {
        let src = "/*\n:section: 1.2 Foo\n:quote: first line\n  second line\n:flags: -DA \"-DB=x y\"\n:flags-icarus: -DC\n*/\nmodule top; endmodule\n";
        let meta = parse_header(src).unwrap();
        assert_eq!(meta["quote"], "first line second line");
        let dir = std::env::temp_dir().join("test1800-header-test");
        fs::create_dir_all(&dir).unwrap();
        let path = dir.join("t.sv");
        fs::write(&path, src).unwrap();
        let tc = load(&dir, &path).unwrap();
        assert_eq!(tc.name, "t");
        assert_eq!(tc.flags("icarus"), ["-DA", "-DB=x y", "-DC"]);
        assert_eq!(tc.flags("verilator"), ["-DA", "-DB=x y"]);
        assert_eq!(tc.test_type, TestType::Simulation);
    }

    #[test]
    fn rejects_unknown_key_and_missing_quote() {
        assert!(parse_header("/*\n:sectoin: 1\n*/").is_err());
        let dir = std::env::temp_dir().join("test1800-header-test2");
        fs::create_dir_all(&dir).unwrap();
        let path = dir.join("t.sv");
        fs::write(&path, "/*\n:section: 1\n*/\n").unwrap();
        assert!(load(&dir, &path).unwrap_err().contains(":quote:"));
    }
}
