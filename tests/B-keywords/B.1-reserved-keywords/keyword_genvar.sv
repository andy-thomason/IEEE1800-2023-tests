/*
:section: Annex B Keywords
:summary: genvar is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword genvar is used as a variable name
*/
module top;
  int genvar;
endmodule
