/*
:section: Annex B Keywords
:summary: negedge is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword negedge is used as a variable name
*/
module top;
  int negedge;
endmodule
