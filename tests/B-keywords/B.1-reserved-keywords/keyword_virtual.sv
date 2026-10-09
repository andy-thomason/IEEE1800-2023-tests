/*
:section: Annex B Keywords
:summary: virtual is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword virtual is used as a variable name
*/
module top;
  int virtual;
endmodule
