/*
:section: Annex B Keywords
:summary: randcase is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword randcase is used as a variable name
*/
module top;
  int randcase;
endmodule
