/*
:section: Annex B Keywords
:summary: intersect is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword intersect is used as a variable name
*/
module top;
  int intersect;
endmodule
