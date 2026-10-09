/*
:section: Annex B Keywords
:summary: throughout is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword throughout is used as a variable name
*/
module top;
  int throughout;
endmodule
