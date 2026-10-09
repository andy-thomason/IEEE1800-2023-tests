/*
:section: Annex B Keywords
:summary: join_any is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword join_any is used as a variable name
*/
module top;
  int join_any;
endmodule
