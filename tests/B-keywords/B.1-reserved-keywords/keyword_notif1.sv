/*
:section: Annex B Keywords
:summary: notif1 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword notif1 is used as a variable name
*/
module top;
  int notif1;
endmodule
