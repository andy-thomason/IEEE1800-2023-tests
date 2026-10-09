/*
:section: Annex B Keywords
:summary: repeat is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword repeat is used as a variable name
*/
module top;
  int repeat;
endmodule
