/*
:section: Annex B Keywords
:summary: xor is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword xor is used as a variable name
*/
module top;
  int xor;
endmodule
