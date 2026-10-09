/*
:section: Annex B Keywords
:summary: expect is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword expect is used as a variable name
*/
module top;
  int expect;
endmodule
