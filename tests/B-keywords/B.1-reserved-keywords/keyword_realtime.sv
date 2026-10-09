/*
:section: Annex B Keywords
:summary: realtime is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword realtime is used as a variable name
*/
module top;
  int realtime;
endmodule
