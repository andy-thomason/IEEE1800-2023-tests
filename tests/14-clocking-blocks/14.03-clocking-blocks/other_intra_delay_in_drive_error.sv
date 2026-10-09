/*
:section: 14.16 Synchronous drives
:summary: Synchronous drives to a clockvar may only use a ## cycle delay, not a # delay.
:type: elaboration
:should_fail_because: a # delay is used in a synchronous drive
*/
module top;
  logic clk, q;
  clocking cb @(posedge clk); output q; endclocking
  initial cb.q <= #3 1'b1;
endmodule
