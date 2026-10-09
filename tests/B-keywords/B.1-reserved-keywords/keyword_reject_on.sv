/*
:section: Annex B Keywords
:summary: reject_on is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword reject_on is used as a variable name
*/
module top;
  int reject_on;
endmodule
