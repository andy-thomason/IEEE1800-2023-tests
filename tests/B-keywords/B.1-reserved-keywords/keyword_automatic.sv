/*
:section: Annex B Keywords
:summary: automatic is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword automatic is used as a variable name
*/
module top;
  int automatic;
endmodule
