/*
:section: Annex B Keywords
:summary: wildcard is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword wildcard is used as a variable name
*/
module top;
  int wildcard;
endmodule
