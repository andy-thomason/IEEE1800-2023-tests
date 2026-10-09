/*
:section: Annex B Keywords
:summary: nettype is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword nettype is used as a variable name
*/
module top;
  int nettype;
endmodule
