/*
:section: Annex B Keywords
:summary: iff is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword iff is used as a variable name
*/
module top;
  int iff;
endmodule
