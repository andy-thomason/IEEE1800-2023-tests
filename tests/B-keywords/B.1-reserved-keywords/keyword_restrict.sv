/*
:section: Annex B Keywords
:summary: restrict is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword restrict is used as a variable name
*/
module top;
  int restrict;
endmodule
