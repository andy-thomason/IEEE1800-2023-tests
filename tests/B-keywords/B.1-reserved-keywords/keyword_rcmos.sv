/*
:section: Annex B Keywords
:summary: rcmos is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword rcmos is used as a variable name
*/
module top;
  int rcmos;
endmodule
