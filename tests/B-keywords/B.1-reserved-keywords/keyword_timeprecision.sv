/*
:section: Annex B Keywords
:summary: timeprecision is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword timeprecision is used as a variable name
*/
module top;
  int timeprecision;
endmodule
