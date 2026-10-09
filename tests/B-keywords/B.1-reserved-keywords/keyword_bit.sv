/*
:section: Annex B Keywords
:summary: bit is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword bit is used as a variable name
*/
module top;
  int bit;
endmodule
