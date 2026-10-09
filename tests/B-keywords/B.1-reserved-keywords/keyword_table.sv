/*
:section: Annex B Keywords
:summary: table is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword table is used as a variable name
*/
module top;
  int table;
endmodule
