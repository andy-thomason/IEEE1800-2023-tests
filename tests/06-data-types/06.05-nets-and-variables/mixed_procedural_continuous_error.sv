/*
:section: 6.5 Nets and variables
:summary: One variable bit must not be driven by both a continuous and a procedural assignment.
:type: elaboration
:should_fail_because: bit 0 of the variable is written both by a continuous assignment
  and by a procedural assignment
*/
module top;
  logic [3:0] bus;
  logic src = 1'b1;
  assign bus[0] = src;
  initial bus[0] = 1'b0;
endmodule
