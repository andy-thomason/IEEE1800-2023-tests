/*
:section: 6.5 Nets and variables
:summary: A variable must not be driven by two separate continuous assignments.
:type: elaboration
:should_fail_because: the variable flag is written by two continuous assignments
*/
module top;
  logic a = 1'b0, b = 1'b1;
  logic flag;
  assign flag = a;
  assign flag = b;
endmodule
