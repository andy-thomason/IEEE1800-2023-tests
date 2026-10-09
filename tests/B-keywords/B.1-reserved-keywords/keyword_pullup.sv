/*
:section: Annex B Keywords
:summary: pullup is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword pullup is used as a variable name
*/
module top;
  int pullup;
endmodule
