/*
:section: Annex B Keywords
:summary: casex is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword casex is used as a variable name
*/
module top;
  int casex;
endmodule
