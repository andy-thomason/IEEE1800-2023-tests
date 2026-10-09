/*
:section: Annex B Keywords
:summary: deassign is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword deassign is used as a variable name
*/
module top;
  int deassign;
endmodule
