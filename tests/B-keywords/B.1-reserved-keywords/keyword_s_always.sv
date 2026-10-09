/*
:section: Annex B Keywords
:summary: s_always is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword s_always is used as a variable name
*/
module top;
  int s_always;
endmodule
