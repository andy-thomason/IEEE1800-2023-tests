/*
:section: Annex B Keywords
:summary: first_match is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword first_match is used as a variable name
*/
module top;
  int first_match;
endmodule
