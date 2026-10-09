/*
:section: Annex B Keywords
:summary: within is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword within is used as a variable name
*/
module top;
  int within;
endmodule
