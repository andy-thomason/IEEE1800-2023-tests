/*
:section: Annex B Keywords
:summary: s_nexttime is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword s_nexttime is used as a variable name
*/
module top;
  int s_nexttime;
endmodule
