/*
:section: Annex B Keywords
:summary: strong1 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword strong1 is used as a variable name
*/
module top;
  int strong1;
endmodule
