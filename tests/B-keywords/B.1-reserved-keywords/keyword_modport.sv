/*
:section: Annex B Keywords
:summary: modport is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword modport is used as a variable name
*/
module top;
  int modport;
endmodule
