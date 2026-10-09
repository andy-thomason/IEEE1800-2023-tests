/*
:section: Annex B Keywords
:summary: solve is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword solve is used as a variable name
*/
module top;
  int solve;
endmodule
