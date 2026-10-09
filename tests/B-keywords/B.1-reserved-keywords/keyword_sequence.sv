/*
:section: Annex B Keywords
:summary: sequence is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword sequence is used as a variable name
*/
module top;
  int sequence;
endmodule
