# test1800

Runs IEEE 1800-2023 (SystemVerilog) conformance tests against a simulator and
writes a Markdown reproducer for every failure.

```sh
cargo run --release -- verilator                 # profile detected from the name
cargo run --release -- /opt/iverilog/bin/iverilog -- -DSOME_DEFINE
cargo run --release -- mytool -p generic -F "-x -y"
cargo run --release -- verilator -k 5.7.1        # only tests whose name/section match
cargo run --release -- --list
```

Output goes to `results/<profile>/` (override with `-o`):

- `summary.md`: one row per test, linking to each failure.
- `failures/<test>.md`: a self-contained reproducer with the quoted section of the
  standard, the test source, the commands to rerun it, and the tool's output.
- `work/<test>/`: build products, kept only for failing tests (`--keep-work` keeps all).

The exit status is 0 if everything passed, 1 if any test failed or was malformed, and 2
for usage errors.

## Profiles

| Profile | Steps |
|---|---|
| `verilator` | `verilator --binary -Wno-fatal --top-module top …`, then run `Vtop`; `--lint-only` for parse/elaboration tests |
| `icarus` | `iverilog -g2012 -s top -o sim.vvp …`, then `vvp -n sim.vvp` |
| `generic` | `<exe> <flags> test.sv`, judged on that single step |

## Writing tests

Tests live under `tests/`, one directory per clause, and run in path order. Each
file is a self-checking module named `top` that starts with a metadata header:

```systemverilog
/*
:section: 20.8.1 Integer math functions
:quote: $clog2 of 0 returns 0.
:type: simulation
:flags-icarus: -DICARUS
*/
```

| Key | Meaning |
|---|---|
| `:section:` | Clause number and title (required) |
| `:quote:` | The requirement being tested, quoted from the standard (required) |
| `:type:` | `parse`, `elaboration` or `simulation` (default) |
| `:should_fail_because:` | The tool must report an error; the reason why |
| `:flags:` / `:flags-<profile>:` | Extra tool flags for this test |
| `:timeout:` | Per-step timeout in seconds |
| `:files:` | More source files, compiled after the test file in this order |
| `:includes:` | Files reached only through `` `include `` (the test's directory is on the include path) |
| `:description:` | Optional notes |

Support files sit next to the test with a `.svh` extension, so they are not run as
tests themselves. Tests that need one compilation unit per file (§3.12.1 case b) pass
`:flags-icarus: -u`; Verilator has no such mode.

Lines without a key continue the previous value. Write `/*` and `*/` inside a quote as `/\*` and `*\/`.

A simulation test passes when every step exits 0, the output contains a line that is
exactly `PASS`, and no line contains `FAIL`. A `should_fail` test passes when the tool
exits with a non-zero status. A crash or a timeout does not count.

Test code is written from the standard's prose. **Do not copy examples from the
standard**; quote the normative text in `:quote:` instead. The PDF is not in the
repository (see `.gitignore`).
