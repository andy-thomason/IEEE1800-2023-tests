/*
:section: Annex B Keywords
:summary: library is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword library is used as a variable name
*/
module top;
  int library;
endmodule
