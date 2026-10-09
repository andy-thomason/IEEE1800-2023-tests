/*
:section: Annex B Keywords
:summary: supply0 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword supply0 is used as a variable name
*/
module top;
  int supply0;
endmodule
