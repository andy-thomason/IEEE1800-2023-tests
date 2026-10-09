/*
:section: 30.4.4.4 The ifnone condition
:summary: ifnone may only qualify a simple module path, not an edge-sensitive path.
:type: parse
:should_fail_because: ifnone is used on an edge-sensitive path
:flags-icarus: -gspecify
*/
module flop(input clk, input d, output reg q);
  always @(posedge clk) q <= d;
  specify
    ifnone (posedge clk => (q : d)) = 4;
  endspecify
endmodule
  module top;
  endmodule
