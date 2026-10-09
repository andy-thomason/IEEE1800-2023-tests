/*
:section: Annex B Keywords
:summary: wand is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword wand is used as a variable name
*/
module top;
  int wand;
endmodule
