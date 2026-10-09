/*
:section: Annex B Keywords
:summary: tranif1 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword tranif1 is used as a variable name
*/
module top;
  int tranif1;
endmodule
