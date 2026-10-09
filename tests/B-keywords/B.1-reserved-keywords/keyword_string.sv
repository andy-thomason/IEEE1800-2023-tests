/*
:section: Annex B Keywords
:summary: string is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword string is used as a variable name
*/
module top;
  int string;
endmodule
