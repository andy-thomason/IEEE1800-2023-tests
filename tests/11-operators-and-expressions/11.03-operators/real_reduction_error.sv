/*
:section: 11.3.1 Operators with real operands
:summary: Reduction operators may not be applied to an operand of type real.
:type: elaboration
:should_fail_because: a reduction operator applied to a real
*/
module top;
  real r = 1.5;
  real y;
  initial y = ^r;
endmodule
