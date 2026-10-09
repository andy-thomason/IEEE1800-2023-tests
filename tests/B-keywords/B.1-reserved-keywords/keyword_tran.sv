/*
:section: Annex B Keywords
:summary: tran is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword tran is used as a variable name
*/
module top;
  int tran;
endmodule
