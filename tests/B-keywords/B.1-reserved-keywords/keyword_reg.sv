/*
:section: Annex B Keywords
:summary: reg is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword reg is used as a variable name
*/
module top;
  int reg;
endmodule
