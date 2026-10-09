/*
:section: Annex B Keywords
:summary: longint is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword longint is used as a variable name
*/
module top;
  int longint;
endmodule
