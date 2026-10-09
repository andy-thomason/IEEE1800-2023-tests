/*
:section: 14.3 Clocking block declaration
:summary: An input clockvar may not be written.
:type: elaboration
:should_fail_because: an input clockvar is written
*/
module top;
  logic clk, d;
  clocking cb @(posedge clk); input d; endclocking
  initial cb.d <= 1'b1;
endmodule
