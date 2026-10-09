/*
:section: Annex B Keywords
:summary: rpmos is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword rpmos is used as a variable name
*/
module top;
  int rpmos;
endmodule
