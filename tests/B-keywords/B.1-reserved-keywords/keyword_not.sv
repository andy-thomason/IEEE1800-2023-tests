/*
:section: Annex B Keywords
:summary: not is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword not is used as a variable name
*/
module top;
  int not;
endmodule
