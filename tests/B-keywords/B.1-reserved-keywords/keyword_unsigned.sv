/*
:section: Annex B Keywords
:summary: unsigned is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword unsigned is used as a variable name
*/
module top;
  int unsigned;
endmodule
