/*
:section: Annex B Keywords
:summary: disable is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword disable is used as a variable name
*/
module top;
  int disable;
endmodule
