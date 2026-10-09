/*
:section: Annex B Keywords
:summary: always_latch is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword always_latch is used as a variable name
*/
module top;
  int always_latch;
endmodule
