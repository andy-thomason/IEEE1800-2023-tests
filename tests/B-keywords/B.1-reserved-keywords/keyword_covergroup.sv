/*
:section: Annex B Keywords
:summary: covergroup is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword covergroup is used as a variable name
*/
module top;
  int covergroup;
endmodule
