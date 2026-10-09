/*
:section: 3.12.1 Compilation units
:summary: When each file is its own compilation unit, its unit-scope declarations are invisible
  to other files.
:type: elaboration
:should_fail_because: with one compilation unit per file, the second file cannot see only_in_first_file,
  which is declared in the first file's compilation-unit scope
:files: separate_units_hide_declarations_error_reader.svh
:flags-icarus: -u
*/
int only_in_first_file = 3;

module top;
  unit_reader u_reader();
endmodule
