/*
:section: Annex B Keywords
:summary: input is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword input is used as a variable name
*/
module top;
  int input;
endmodule
