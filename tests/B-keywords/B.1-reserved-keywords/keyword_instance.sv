/*
:section: Annex B Keywords
:summary: instance is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword instance is used as a variable name
*/
module top;
  int instance;
endmodule
