/*
:section: Annex B Keywords
:summary: endspecify is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword endspecify is used as a variable name
*/
module top;
  int endspecify;
endmodule
