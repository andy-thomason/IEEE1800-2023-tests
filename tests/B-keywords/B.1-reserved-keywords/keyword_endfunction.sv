/*
:section: Annex B Keywords
:summary: endfunction is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword endfunction is used as a variable name
*/
module top;
  int endfunction;
endmodule
