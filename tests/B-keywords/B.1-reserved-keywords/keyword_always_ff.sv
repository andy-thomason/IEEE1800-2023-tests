/*
:section: Annex B Keywords
:summary: always_ff is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword always_ff is used as a variable name
*/
module top;
  int always_ff;
endmodule
