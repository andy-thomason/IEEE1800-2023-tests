/*
:section: Annex B Keywords
:summary: pure is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword pure is used as a variable name
*/
module top;
  int pure;
endmodule
