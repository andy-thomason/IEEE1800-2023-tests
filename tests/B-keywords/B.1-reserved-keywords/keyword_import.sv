/*
:section: Annex B Keywords
:summary: import is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword import is used as a variable name
*/
module top;
  int import;
endmodule
