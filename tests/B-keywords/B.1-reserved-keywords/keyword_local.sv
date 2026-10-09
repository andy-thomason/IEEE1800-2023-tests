/*
:section: Annex B Keywords
:summary: local is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword local is used as a variable name
*/
module top;
  int local;
endmodule
