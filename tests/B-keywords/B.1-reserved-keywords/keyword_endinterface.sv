/*
:section: Annex B Keywords
:summary: endinterface is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword endinterface is used as a variable name
*/
module top;
  int endinterface;
endmodule
