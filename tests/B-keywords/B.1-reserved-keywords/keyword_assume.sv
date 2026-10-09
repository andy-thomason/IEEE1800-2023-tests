/*
:section: Annex B Keywords
:summary: assume is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword assume is used as a variable name
*/
module top;
  int assume;
endmodule
