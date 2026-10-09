/*
:section: Annex B Keywords
:summary: inout is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword inout is used as a variable name
*/
module top;
  int inout;
endmodule
