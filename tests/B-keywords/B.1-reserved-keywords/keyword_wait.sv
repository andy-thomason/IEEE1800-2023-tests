/*
:section: Annex B Keywords
:summary: wait is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword wait is used as a variable name
*/
module top;
  int wait;
endmodule
