/*
:section: 14.16 Synchronous drives
:summary: A clockvar may not be written using a continuous assign.
:type: elaboration
:should_fail_because: a continuous assignment writes to a clockvar
*/
module top;
  logic clk, q;
  clocking cb @(posedge clk); output q; endclocking
  assign cb.q = 1'b1;
endmodule
