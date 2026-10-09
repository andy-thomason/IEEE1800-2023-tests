/*
:section: Annex B Keywords
:summary: rtran is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword rtran is used as a variable name
*/
module top;
  int rtran;
endmodule
