/*
:section: Annex B Keywords
:summary: priority is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword priority is used as a variable name
*/
module top;
  int priority;
endmodule
