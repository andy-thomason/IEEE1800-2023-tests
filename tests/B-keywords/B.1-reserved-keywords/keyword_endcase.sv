/*
:section: Annex B Keywords
:summary: endcase is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword endcase is used as a variable name
*/
module top;
  int endcase;
endmodule
