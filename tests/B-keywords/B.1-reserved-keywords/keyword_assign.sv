/*
:section: Annex B Keywords
:summary: assign is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword assign is used as a variable name
*/
module top;
  int assign;
endmodule
