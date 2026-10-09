/*
:section: Annex B Keywords
:summary: endsequence is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword endsequence is used as a variable name
*/
module top;
  int endsequence;
endmodule
