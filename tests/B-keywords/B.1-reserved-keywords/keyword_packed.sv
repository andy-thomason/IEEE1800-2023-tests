/*
:section: Annex B Keywords
:summary: packed is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword packed is used as a variable name
*/
module top;
  int packed;
endmodule
