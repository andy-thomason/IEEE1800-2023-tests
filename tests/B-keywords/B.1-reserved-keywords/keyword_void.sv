/*
:section: Annex B Keywords
:summary: void is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword void is used as a variable name
*/
module top;
  int void;
endmodule
