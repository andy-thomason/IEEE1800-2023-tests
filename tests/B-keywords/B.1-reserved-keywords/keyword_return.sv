/*
:section: Annex B Keywords
:summary: return is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword return is used as a variable name
*/
module top;
  int return;
endmodule
