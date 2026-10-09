/*
:section: Annex B Keywords
:summary: unique0 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword unique0 is used as a variable name
*/
module top;
  int unique0;
endmodule
