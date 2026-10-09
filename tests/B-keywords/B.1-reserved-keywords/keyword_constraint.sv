/*
:section: Annex B Keywords
:summary: constraint is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword constraint is used as a variable name
*/
module top;
  int constraint;
endmodule
