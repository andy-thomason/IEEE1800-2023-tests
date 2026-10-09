/*
:section: Annex B Keywords
:summary: fork is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword fork is used as a variable name
*/
module top;
  int fork;
endmodule
