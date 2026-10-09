/*
:section: Annex B Keywords
:summary: alias is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword alias is used as a variable name
*/
module top;
  int alias;
endmodule
