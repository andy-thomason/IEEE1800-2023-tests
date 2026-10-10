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
- `failures/<test>.md`: a self-contained reproducer with the section of the
  standard and a summary of the requirement, the test source, the commands to rerun it, and the tool's output.
- `work/<test>/`: build products and any files the test writes, kept only for failing tests
  (`--keep-work` keeps all). The tools run with this as their current directory.

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
:summary: $clog2 of 0 returns 0.
:type: simulation
:flags-icarus: -DICARUS
*/
```

| Key | Meaning |
|---|---|
| `:section:` | Clause number and title (required) |
| `:summary:` | One short sentence paraphrasing the requirement under test, in our own words (required) |
| `:type:` | `parse`, `elaboration` or `simulation` (default) |
| `:should_fail_because:` | The tool must report an error; the reason why |
| `:flags:` / `:flags-<profile>:` | Extra tool flags for this test |
| `:timeout:` | Per-step timeout in seconds |
| `:files:` | More source files, compiled after the test file in this order |
| `:dpi:` | C sources implementing `import "DPI-C"` functions; compiled by Verilator and the generic profile (Icarus has no DPI-C) |
| `:vpi:` | C sources of a VPI application; its `vlog_startup_routines` register the system tasks and functions the test calls. Icarus builds it with `iverilog-vpi` and loads it into `vvp`; Verilator gets `--vpi` and the sources |
| `:plusargs:` | Arguments given to the simulation run step (e.g. `+VERBOSE +N=3`) |
| `:data:` | Files copied into the work directory, which is the current directory while the tools run (e.g. `$readmemh` input) |
| `:expect:` | Output lines that must appear in this order (one per line; compared after trimming). Replaces the `PASS` check |
| `:includes:` | Files reached only through `` `include `` (the test's directory is on the include path) |
| `:description:` | Optional notes |

Support files sit next to the test with a `.svh` extension, so they are not run as
tests themselves. Tests that need one compilation unit per file (§3.12.1 case b) pass
`:flags-icarus: -u`; Verilator has no such mode.

Lines without a key continue the previous value. Write `/*` and `*/` inside a value as `/\*` and `*\/`.

A simulation test passes when every step exits 0, the output contains a line that is
exactly `PASS`, and no line contains `FAIL`. A `should_fail` test passes when the tool
exits with a non-zero status. A crash or a timeout does not count.

Test code is written from the standard's prose. **Do not copy text or examples from
the standard**: cite the clause in `:section:` and paraphrase the requirement in
`:summary:`. The PDF is not in the repository (see `.gitignore`).
