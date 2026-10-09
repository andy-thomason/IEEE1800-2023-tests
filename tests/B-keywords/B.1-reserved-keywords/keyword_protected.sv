/*
:section: Annex B Keywords
:summary: protected is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword protected is used as a variable name
*/
module top;
  int protected;
endmodule
