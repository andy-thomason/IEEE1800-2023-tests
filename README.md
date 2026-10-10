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

## Results

Results from running the full suite on the versions below (Verilator 66.8%, Icarus 68.6% passing).

- Verilator: `Verilator 5.053 devel rev vUNKNOWN-built20261009-bdfb2e8`
- Icarus: `Icarus Verilog version 14.0 (devel) (467d830)`

| Clause | Tests | Verilator pass | Verilator fail | Icarus pass | Icarus fail |
|---|---:|---:|---:|---:|---:|
| 03 Design and verification building blocks | 62 | 36 | 26 | 55 | 7 |
| 04 Scheduling semantics | 18 | 12 | 6 | 15 | 3 |
| 05 Lexical conventions | 77 | 61 | 16 | 66 | 11 |
| 06 Data types | 221 | 149 | 72 | 153 | 68 |
| 07 Aggregate data types | 95 | 52 | 43 | 41 | 54 |
| 08 Classes | 68 | 53 | 15 | 33 | 35 |
| 09 Processes | 33 | 20 | 13 | 26 | 7 |
| 10 Assignment statements | 33 | 21 | 12 | 23 | 10 |
| 11 Operators and expressions | 73 | 42 | 31 | 56 | 17 |
| 12 Procedural programming statements | 21 | 13 | 8 | 12 | 9 |
| 13 Tasks and functions | 27 | 22 | 5 | 21 | 6 |
| 14 Clocking blocks | 18 | 17 | 1 | 8 | 10 |
| 15 Interprocess synchronization | 13 | 7 | 6 | 3 | 10 |
| 16 Assertions | 27 | 15 | 12 | 5 | 22 |
| 17 Checkers | 9 | 4 | 5 | 5 | 4 |
| 18 Constrained random | 27 | 23 | 4 | 2 | 25 |
| 19 Functional coverage | 14 | 2 | 12 | 1 | 13 |
| 20 Utility system tasks | 22 | 15 | 7 | 10 | 12 |
| 21 I/O system tasks | 15 | 8 | 7 | 13 | 2 |
| 22 Compiler directives | 21 | 17 | 4 | 14 | 7 |
| 23 Modules and hierarchy | 35 | 21 | 14 | 24 | 11 |
| 24 Programs | 18 | 9 | 9 | 10 | 8 |
| 25 Interfaces | 41 | 26 | 15 | 27 | 14 |
| 26 Packages | 26 | 18 | 8 | 21 | 5 |
| 27 Generate constructs | 27 | 23 | 4 | 27 | 0 |
| 28 Gate and switch modeling | 34 | 11 | 23 | 29 | 5 |
| 29 UDPs | 26 | 8 | 18 | 18 | 8 |
| 30 Specify blocks | 24 | 4 | 20 | 14 | 10 |
| 31 Timing checks | 24 | 3 | 21 | 5 | 19 |
| 32 SDF | 10 | 0 | 10 | 3 | 7 |
| 33 Configurations | 12 | 8 | 4 | 6 | 6 |
| 34 Protected envelopes | 2 | 0 | 2 | 2 | 0 |
| 35 DPI | 19 | 9 | 10 | 7 | 12 |
| 36–38 VPI | 13 | 0 | 13 | 10 | 3 |
| 39 Assertion API | 2 | 0 | 2 | 0 | 2 |
| 40 Coverage API | 5 | 1 | 4 | 0 | 5 |
| Annex B Keywords | 248 | 247 | 1 | 248 | 0 |
| Annex G std package | 5 | 3 | 2 | 1 | 4 |
| Annex H DPI C layer | 13 | 8 | 5 | 0 | 13 |
| **Total** | **1478** | **988** | **490** | **1014** | **464** |

A test fails when the tool rejects legal code, accepts illegal code, crashes, times out, or produces wrong results. Many failures are features the tool does not implement yet. Rerun with `cargo run --release -- verilator` or `-- iverilog` and see `results/<profile>/summary.md` for per-test details and reproducers.

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
