/*
:section: Annex B Keywords
:summary: design is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword design is used as a variable name
*/
module top;
  int design;
endmodule
