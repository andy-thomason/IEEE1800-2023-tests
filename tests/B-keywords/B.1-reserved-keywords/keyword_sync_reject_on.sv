/*
:section: Annex B Keywords
:summary: sync_reject_on is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword sync_reject_on is used as a variable name
*/
module top;
  int sync_reject_on;
endmodule
