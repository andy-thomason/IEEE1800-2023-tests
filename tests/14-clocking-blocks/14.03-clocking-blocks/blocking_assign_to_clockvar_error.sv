/*
:section: 14.16 Synchronous drives
:summary: A clockvar may not be written using a blocking assignment.
:type: elaboration
:should_fail_because: a blocking assignment writes to a clockvar
*/
module top;
  logic clk, q;
  clocking cb @(posedge clk); output q; endclocking
  initial cb.q = 1'b1;
endmodule
