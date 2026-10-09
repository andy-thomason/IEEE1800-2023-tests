/*
:section: Annex B Keywords
:summary: casez is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword casez is used as a variable name
*/
module top;
  int casez;
endmodule
