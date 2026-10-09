/*
:section: Annex B Keywords
:summary: real is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword real is used as a variable name
*/
module top;
  int real;
endmodule
