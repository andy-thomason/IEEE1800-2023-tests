/*
:section: Annex B Keywords
:summary: strong0 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword strong0 is used as a variable name
*/
module top;
  int strong0;
endmodule
