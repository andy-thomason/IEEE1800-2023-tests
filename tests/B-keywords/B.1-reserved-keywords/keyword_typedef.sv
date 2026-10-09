/*
:section: Annex B Keywords
:summary: typedef is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword typedef is used as a variable name
*/
module top;
  int typedef;
endmodule
