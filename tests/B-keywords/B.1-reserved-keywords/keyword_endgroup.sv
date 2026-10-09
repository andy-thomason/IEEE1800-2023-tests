/*
:section: Annex B Keywords
:summary: endgroup is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword endgroup is used as a variable name
*/
module top;
  int endgroup;
endmodule
