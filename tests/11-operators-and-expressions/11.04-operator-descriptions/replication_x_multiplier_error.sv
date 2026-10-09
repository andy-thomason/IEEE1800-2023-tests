/*
:section: 11.4.12.1 Replication operator
:summary: A replication count containing x or z bits is illegal.
:type: elaboration
:should_fail_because: the replication multiplier is x
*/
module top;
  logic [7:0] r;
  initial r = {1'bx{1'b0}};
endmodule
