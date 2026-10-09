/*
:section: Annex B Keywords
:summary: s_eventually is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword s_eventually is used as a variable name
*/
module top;
  int s_eventually;
endmodule
