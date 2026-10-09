/*
:section: Annex B Keywords
:summary: defparam is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword defparam is used as a variable name
*/
module top;
  int defparam;
endmodule
