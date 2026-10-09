/*
:section: Annex B Keywords
:summary: continue is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword continue is used as a variable name
*/
module top;
  int continue;
endmodule
