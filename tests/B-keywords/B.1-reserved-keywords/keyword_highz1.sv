/*
:section: Annex B Keywords
:summary: highz1 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword highz1 is used as a variable name
*/
module top;
  int highz1;
endmodule
