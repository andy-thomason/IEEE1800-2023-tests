/*
:section: Annex B Keywords
:summary: release is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword release is used as a variable name
*/
module top;
  int release;
endmodule
