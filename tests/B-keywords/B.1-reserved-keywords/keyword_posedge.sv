/*
:section: Annex B Keywords
:summary: posedge is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword posedge is used as a variable name
*/
module top;
  int posedge;
endmodule
