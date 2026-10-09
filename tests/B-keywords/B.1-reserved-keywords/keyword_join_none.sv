/*
:section: Annex B Keywords
:summary: join_none is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword join_none is used as a variable name
*/
module top;
  int join_none;
endmodule
