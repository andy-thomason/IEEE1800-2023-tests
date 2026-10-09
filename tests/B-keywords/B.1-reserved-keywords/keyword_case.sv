/*
:section: Annex B Keywords
:summary: case is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword case is used as a variable name
*/
module top;
  int case;
endmodule
