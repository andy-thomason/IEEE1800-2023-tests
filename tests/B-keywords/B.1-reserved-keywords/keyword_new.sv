/*
:section: Annex B Keywords
:summary: new is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword new is used as a variable name
*/
module top;
  int new;
endmodule
