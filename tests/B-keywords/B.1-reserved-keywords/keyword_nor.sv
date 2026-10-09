/*
:section: Annex B Keywords
:summary: nor is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword nor is used as a variable name
*/
module top;
  int nor;
endmodule
