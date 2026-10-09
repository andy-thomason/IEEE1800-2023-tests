/*
:section: Annex B Keywords
:summary: static is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword static is used as a variable name
*/
module top;
  int static;
endmodule
