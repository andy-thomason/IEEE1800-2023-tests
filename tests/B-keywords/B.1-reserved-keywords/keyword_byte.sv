/*
:section: Annex B Keywords
:summary: byte is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword byte is used as a variable name
*/
module top;
  int byte;
endmodule
