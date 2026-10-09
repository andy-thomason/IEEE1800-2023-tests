/*
:section: 28.3.6 Primitive instance connection list
:summary: A gate instance array connection must supply exactly the required number of bits.
:type: elaboration
:should_fail_because: a 3-bit expression is connected to a 4-instance array
*/
module top;
  logic [2:0] a;
  logic [3:0] b;
  wire [3:0] y;
  and g[3:0] (y, a, b);
endmodule
