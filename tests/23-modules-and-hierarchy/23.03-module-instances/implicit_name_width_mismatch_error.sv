/*
:section: 23.3.2.3 Connecting module instance using implicit named port connections (.name)
:summary: An implicit .name connection is illegal when the two sides do not have equivalent
  types.
:type: elaboration
:should_fail_because: .a connects an 8-bit variable to a 4-bit port
*/
module m(input [3:0] a); endmodule
module top;
  logic [7:0] a;
  m u(.a);
endmodule
