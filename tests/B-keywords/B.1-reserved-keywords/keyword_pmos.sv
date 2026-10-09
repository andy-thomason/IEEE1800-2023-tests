/*
:section: Annex B Keywords
:summary: pmos is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword pmos is used as a variable name
*/
module top;
  int pmos;
endmodule
