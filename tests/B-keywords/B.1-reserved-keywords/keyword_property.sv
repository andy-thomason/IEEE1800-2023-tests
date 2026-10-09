/*
:section: Annex B Keywords
:summary: property is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword property is used as a variable name
*/
module top;
  int property;
endmodule
