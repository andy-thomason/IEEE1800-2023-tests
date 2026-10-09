/*
:section: 6.5 Nets and variables
:summary: A module must not assign to a variable that is one of its own input ports.
:type: elaboration
:should_fail_because: a variable declared as an input port is assigned inside the module
*/
module receiver(input var logic [3:0] in);
  initial in = 4'd2;
endmodule

module top;
  logic [3:0] v = 4'd1;
  receiver u(.in(v));
endmodule
