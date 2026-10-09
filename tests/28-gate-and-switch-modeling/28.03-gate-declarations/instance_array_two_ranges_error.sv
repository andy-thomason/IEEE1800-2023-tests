/*
:section: 28.3.5 The range specification
:summary: A single instance array name cannot be declared with two separate ranges.
:type: elaboration
:should_fail_because: one instance name is given two ranges
*/
module top;
  logic [7:0] a, b;
  wire [7:0] y;
  nand g[3:0] (y[3:0], a[3:0], b[3:0]), g[7:4] (y[7:4], a[7:4], b[7:4]);
endmodule
