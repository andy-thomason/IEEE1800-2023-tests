/*
:section: Annex B Keywords
:summary: randsequence is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword randsequence is used as a variable name
*/
module top;
  int randsequence;
endmodule
