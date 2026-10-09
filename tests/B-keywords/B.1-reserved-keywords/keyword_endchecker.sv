/*
:section: Annex B Keywords
:summary: endchecker is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword endchecker is used as a variable name
*/
module top;
  int endchecker;
endmodule
