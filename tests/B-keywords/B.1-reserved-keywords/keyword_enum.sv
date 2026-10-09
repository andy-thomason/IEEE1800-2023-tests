/*
:section: Annex B Keywords
:summary: enum is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword enum is used as a variable name
*/
module top;
  int enum;
endmodule
