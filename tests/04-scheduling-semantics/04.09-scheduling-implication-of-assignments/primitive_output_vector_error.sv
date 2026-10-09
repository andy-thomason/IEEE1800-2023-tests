/*
:section: 4.9.6 Port connections
:summary: A single-bit gate output terminal must not be connected to a multi-bit net.
:type: elaboration
:should_fail_because: the output terminal of a single gate is connected to a 2-bit net
*/
module top;
  logic a = 1, b = 1;
  wire [1:0] y;
  and g(y, a, b);
endmodule
