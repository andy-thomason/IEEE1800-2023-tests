/*
:section: 31.2 Overview
:summary: Timing checks like $setup may not be called from procedural code such as an initial
  block.
:type: parse
:should_fail_because: a timing check is used in an initial procedure
:flags-icarus: -gspecify
*/
module top;
  logic clk, d;
  initial $setup(d, posedge clk, 10);
endmodule
