/*
:section: 6.24.1 Cast operator
:summary: A signed' cast requires an integral operand, so applying it to a real is illegal.
:type: elaboration
:should_fail_because: signed'() is applied to a real
*/
module top;
  real r = 2.5;
  logic signed [7:0] s;
  initial s = signed'(r);
endmodule
