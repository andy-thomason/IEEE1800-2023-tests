/*
:section: 5.7.1 Integer literal constants
:summary: White space must not appear between the apostrophe and the base letter of a literal.
:type: parse
:should_fail_because: white space separates the apostrophe from the base letter
*/
module top;
  logic [7:0] v = 8' hC4;
endmodule
