/*
:section: 6.5 Nets and variables
:summary: A declaration initializer counts as a procedural write, so adding a continuous
  assignment is illegal.
:type: elaboration
:should_fail_because: a declaration initialiser counts as a procedural write, so the continuous assignment
  conflicts
*/
  module top;
    logic v = 1'b0;
assign v = 1'b1;
  endmodule
