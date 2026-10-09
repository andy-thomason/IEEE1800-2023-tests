/*
:section: Annex B Keywords
:summary: tri1 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword tri1 is used as a variable name
*/
module top;
  int tri1;
endmodule
