/*
:section: Annex B Keywords
:summary: dist is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword dist is used as a variable name
*/
module top;
  int dist;
endmodule
