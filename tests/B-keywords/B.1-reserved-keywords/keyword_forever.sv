/*
:section: Annex B Keywords
:summary: forever is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword forever is used as a variable name
*/
module top;
  int forever;
endmodule
