/*
:section: 11.3.1 Operators with real operands
:summary: Shift operators may not be applied to an operand of type real.
:type: elaboration
:should_fail_because: a shift applied to a real
*/
module top;
  real r = 1.5;
  real y;
  initial y = r << 1;
endmodule
