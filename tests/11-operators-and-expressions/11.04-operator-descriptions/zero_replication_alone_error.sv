/*
:section: 11.4.12.1 Replication operator
:summary: A zero-count replication may not form a concatenation on its own without a positively
  sized operand.
:type: elaboration
:should_fail_because: a zero replication is the only item
*/
module top;
  parameter int Z = 0;
  logic [7:0] r;
  initial r = {Z{1'b1}};
endmodule
