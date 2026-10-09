/*
:section: Annex B Keywords
:summary: interface is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword interface is used as a variable name
*/
module top;
  int interface;
endmodule
