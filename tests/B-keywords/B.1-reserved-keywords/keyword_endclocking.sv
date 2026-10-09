/*
:section: Annex B Keywords
:summary: endclocking is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword endclocking is used as a variable name
*/
module top;
  int endclocking;
endmodule
