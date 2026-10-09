/*
:section: Annex B Keywords
:summary: function is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword function is used as a variable name
*/
module top;
  int function;
endmodule
