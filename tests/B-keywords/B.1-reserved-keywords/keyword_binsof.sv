/*
:section: Annex B Keywords
:summary: binsof is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword binsof is used as a variable name
*/
module top;
  int binsof;
endmodule
