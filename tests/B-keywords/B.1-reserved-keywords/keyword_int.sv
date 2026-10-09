/*
:section: Annex B Keywords
:summary: int is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword int is used as a variable name
*/
module top;
  int int;
endmodule
