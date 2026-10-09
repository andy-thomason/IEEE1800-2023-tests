/*
:section: Annex B Keywords
:summary: logic is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword logic is used as a variable name
*/
module top;
  int logic;
endmodule
