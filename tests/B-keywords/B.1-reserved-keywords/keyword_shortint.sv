/*
:section: Annex B Keywords
:summary: shortint is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword shortint is used as a variable name
*/
module top;
  int shortint;
endmodule
