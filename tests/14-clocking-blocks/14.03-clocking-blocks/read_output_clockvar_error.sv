/*
:section: 14.3 Clocking block declaration
:summary: An output clockvar may not be read.
:type: elaboration
:should_fail_because: an output clockvar is read
*/
module top;
  logic clk, q, r;
  clocking cb @(posedge clk); output q; endclocking
  initial r = cb.q;
endmodule
