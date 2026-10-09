/*
:section: Annex B Keywords
:summary: until is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword until is used as a variable name
*/
module top;
  int until;
endmodule
