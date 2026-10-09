/*
:section: Annex B Keywords
:summary: macromodule is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword macromodule is used as a variable name
*/
module top;
  int macromodule;
endmodule
