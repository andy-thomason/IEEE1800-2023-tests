/*
:section: Annex B Keywords
:summary: notif0 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword notif0 is used as a variable name
*/
module top;
  int notif0;
endmodule
