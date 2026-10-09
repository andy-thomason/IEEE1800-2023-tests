/*
:section: 6.24.1 Cast operator
:summary: A size cast requires an integral operand, so applying it to a real is illegal.
:type: elaboration
:should_fail_because: a size cast is applied to a real
*/
module top;
  real r = 2.5;
  logic [7:0] v;
  initial v = 8'(r);
endmodule
