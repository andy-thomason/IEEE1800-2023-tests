/*
:section: Annex B Keywords
:summary: bufif1 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword bufif1 is used as a variable name
*/
module top;
  int bufif1;
endmodule
