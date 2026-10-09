/*
:section: Annex B Keywords
:summary: tranif0 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword tranif0 is used as a variable name
*/
module top;
  int tranif0;
endmodule
