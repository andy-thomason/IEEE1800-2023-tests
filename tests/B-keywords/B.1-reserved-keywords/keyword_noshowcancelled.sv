/*
:section: Annex B Keywords
:summary: noshowcancelled is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword noshowcancelled is used as a variable name
*/
module top;
  int noshowcancelled;
endmodule
