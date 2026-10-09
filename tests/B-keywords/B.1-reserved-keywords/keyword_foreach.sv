/*
:section: Annex B Keywords
:summary: foreach is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword foreach is used as a variable name
*/
module top;
  int foreach;
endmodule
