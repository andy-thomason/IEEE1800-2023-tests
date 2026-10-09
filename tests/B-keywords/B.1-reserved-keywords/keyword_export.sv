/*
:section: Annex B Keywords
:summary: export is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword export is used as a variable name
*/
module top;
  int export;
endmodule
