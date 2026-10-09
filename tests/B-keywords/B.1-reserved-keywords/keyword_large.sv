/*
:section: Annex B Keywords
:summary: large is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword large is used as a variable name
*/
module top;
  int large;
endmodule
