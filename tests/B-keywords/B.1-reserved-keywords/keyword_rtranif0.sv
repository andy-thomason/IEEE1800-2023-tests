/*
:section: Annex B Keywords
:summary: rtranif0 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword rtranif0 is used as a variable name
*/
module top;
  int rtranif0;
endmodule
