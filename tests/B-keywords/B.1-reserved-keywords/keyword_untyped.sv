/*
:section: Annex B Keywords
:summary: untyped is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword untyped is used as a variable name
*/
module top;
  int untyped;
endmodule
