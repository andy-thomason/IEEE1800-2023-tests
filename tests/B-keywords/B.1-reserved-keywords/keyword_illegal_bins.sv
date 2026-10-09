/*
:section: Annex B Keywords
:summary: illegal_bins is a reserved keyword, so it cannot be used as an identifier.
:type: parse
:should_fail_because: the reserved keyword illegal_bins is used as a variable name
*/
module top;
  int illegal_bins;
endmodule
