/*
:section: 14.12 Default clocking
:summary: A module may declare only one default clocking.
:type: elaboration
:should_fail_because: two default clockings in one module
*/
module top;
  logic clk;
  default clocking a @(posedge clk); endclocking
  default clocking b @(negedge clk); endclocking
endmodule
