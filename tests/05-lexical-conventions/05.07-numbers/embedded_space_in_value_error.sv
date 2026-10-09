/*
:section: 5.7 Numbers
:summary: White space inside the digits of a numeric literal is illegal.
:type: parse
:should_fail_because: the binary value contains a space
*/
module top;
  logic [7:0] v = 8'b1010 0101;
endmodule
