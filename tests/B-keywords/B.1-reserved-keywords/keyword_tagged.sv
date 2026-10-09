/*
:section: Annex B Keywords
:summary: tagged is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword tagged is used as a variable name
*/
module top;
  int tagged;
endmodule
