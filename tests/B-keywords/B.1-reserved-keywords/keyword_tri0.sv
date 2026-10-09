/*
:section: Annex B Keywords
:summary: tri0 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword tri0 is used as a variable name
*/
module top;
  int tri0;
endmodule
