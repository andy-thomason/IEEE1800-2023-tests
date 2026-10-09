/*
:section: Annex B Keywords
:summary: generate is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword generate is used as a variable name
*/
module top;
  int generate;
endmodule
