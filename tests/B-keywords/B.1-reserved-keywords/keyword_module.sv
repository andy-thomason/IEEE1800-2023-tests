/*
:section: Annex B Keywords
:summary: module is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword module is used as a variable name
*/
module top;
  int module;
endmodule
