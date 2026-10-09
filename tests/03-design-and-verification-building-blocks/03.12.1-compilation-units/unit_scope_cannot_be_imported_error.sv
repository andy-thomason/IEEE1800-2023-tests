/*
:section: 3.12.1 Compilation units
:summary: Because $unit has no name usable by import, writing import $unit::* is illegal.
:type: parse
:should_fail_because: $unit cannot appear in an import declaration
*/
int shared_value = 1;

module top;
  import $unit::*;
endmodule
