/*
:section: Annex B Keywords
:summary: wor is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword wor is used as a variable name
*/
module top;
  int wor;
endmodule
