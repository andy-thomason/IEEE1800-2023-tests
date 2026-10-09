/*
:section: Annex B Keywords
:summary: shortreal is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword shortreal is used as a variable name
*/
module top;
  int shortreal;
endmodule
