/*
:section: Annex B Keywords
:summary: s_until is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword s_until is used as a variable name
*/
module top;
  int s_until;
endmodule
