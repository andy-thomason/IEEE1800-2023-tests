/*
:section: Annex B Keywords
:summary: incdir is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword incdir is used as a variable name
*/
module top;
  int incdir;
endmodule
