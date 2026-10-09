/*
:section: 11.3.1 Operators with real operands
:summary: Bitwise operators such as & cannot be applied to real operands.
:type: elaboration
:should_fail_because: & applied to a real
*/
module top;
  real r = 1.5;
  real y;
  initial y = r & 1;
endmodule
