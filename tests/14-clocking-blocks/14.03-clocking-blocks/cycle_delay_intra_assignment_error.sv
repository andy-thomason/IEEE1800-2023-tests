/*
:section: 14.11 Cycle delay: ##
:summary: A ## cycle delay may not be used as an intra-assignment delay.
:type: elaboration
:should_fail_because: ## is used as an intra-assignment delay
*/
module top;
  logic clk;
  int a, b;
  default clocking cb @(posedge clk); endclocking
  initial a = ##2 b;
endmodule
