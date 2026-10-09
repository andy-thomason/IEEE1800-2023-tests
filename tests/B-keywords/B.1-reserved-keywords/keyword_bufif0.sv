/*
:section: Annex B Keywords
:summary: bufif0 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword bufif0 is used as a variable name
*/
module top;
  int bufif0;
endmodule
