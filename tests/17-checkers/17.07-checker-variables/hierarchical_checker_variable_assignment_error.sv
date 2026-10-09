/*
:section: 17.7.1 Checker variable assignments
:summary: Assigning to a checker variable from outside through a hierarchical name is illegal.
:type: elaboration
:should_fail_because: a checker variable is assigned through a hierarchical name
*/
checker hold_chk (logic a, event clock);
  bit stored;
  always_ff @(clock) stored <= a;
endchecker
module top;
  logic clk, a;
  hold_chk u(a, posedge clk);
  initial u.stored = 1'b1;
endmodule
