/*
:section: Annex B Keywords
:summary: highz0 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword highz0 is used as a variable name
*/
module top;
  int highz0;
endmodule
