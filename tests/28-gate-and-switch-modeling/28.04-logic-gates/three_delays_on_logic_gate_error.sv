/*
:section: 28.4 and, nand, nor, or, xor, and xnor gates
:summary: Logic gates such as and allow at most two delays, so three is illegal.
:type: elaboration
:should_fail_because: an and gate has three delays
*/
module top;
  logic a, b;
  wire y;
  and #(1, 2, 3) g(y, a, b);
endmodule
