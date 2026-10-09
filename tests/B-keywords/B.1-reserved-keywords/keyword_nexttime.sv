/*
:section: Annex B Keywords
:summary: nexttime is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword nexttime is used as a variable name
*/
module top;
  int nexttime;
endmodule
