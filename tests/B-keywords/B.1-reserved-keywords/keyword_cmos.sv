/*
:section: Annex B Keywords
:summary: cmos is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword cmos is used as a variable name
*/
module top;
  int cmos;
endmodule
