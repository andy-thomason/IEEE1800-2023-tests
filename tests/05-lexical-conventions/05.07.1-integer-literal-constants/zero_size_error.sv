/*
:section: 5.7.1 Integer literal constants
:summary: The size of an integer literal must not be zero.
:type: parse
:should_fail_because: the size constant is zero
*/
module top;
  logic [3:0] v = 0'd5;
endmodule
