/*
:section: 6.5 Nets and variables
:summary: A variable must not be connected to an inout port.
:type: elaboration
:should_fail_because: a variable is connected to an inout port
*/
module bidir(inout wire [3:0] io);
endmodule

module top;
  logic [3:0] v;
  bidir u(.io(v));
endmodule
