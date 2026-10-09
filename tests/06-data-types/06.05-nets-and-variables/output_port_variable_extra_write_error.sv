/*
:section: 6.5 Nets and variables
:summary: A variable driven by an instance output port must not also receive procedural
  assignments.
:type: elaboration
:should_fail_because: a variable driven by an output port is also assigned procedurally
*/
module source(output logic [3:0] o);
  assign o = 4'd7;
endmodule

module top;
  logic [3:0] v;
  source u(.o(v));
  initial v = 4'd1;
endmodule
