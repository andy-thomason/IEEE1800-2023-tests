/*
:section: Annex B Keywords
:summary: weak is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword weak is used as a variable name
*/
module top;
  int weak;
endmodule
