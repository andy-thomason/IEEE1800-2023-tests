/*
:section: 6.5 Nets and variables
:summary: Nets may not be the target of procedural assignments.
:type: elaboration
:should_fail_because: a net is assigned procedurally
*/
  module top;
    wire w;
initial w = 1'b1;
  endmodule
