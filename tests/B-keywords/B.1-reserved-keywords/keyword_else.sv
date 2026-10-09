/*
:section: Annex B Keywords
:summary: else is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword else is used as a variable name
*/
module top;
  int else;
endmodule
