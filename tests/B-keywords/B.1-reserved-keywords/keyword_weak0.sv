/*
:section: Annex B Keywords
:summary: weak0 is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword weak0 is used as a variable name
*/
module top;
  int weak0;
endmodule
