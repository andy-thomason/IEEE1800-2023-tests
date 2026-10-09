/*
:section: Annex B Keywords
:summary: pull1 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword pull1 is used as a variable name
*/
module top;
  int pull1;
endmodule
