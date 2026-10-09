/*
:section: Annex B Keywords
:summary: edge is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword edge is used as a variable name
*/
module top;
  int edge;
endmodule
