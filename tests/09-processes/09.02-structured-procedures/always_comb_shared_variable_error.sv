/*
:section: 9.2.2.2 Combinational logic always_comb procedure
:summary: A variable driven by always_comb must not be written by any other process.
:type: elaboration
:should_fail_because: a variable written by always_comb is also written by another process
*/
module top;
  logic a, y;
  always_comb y = a;
  initial y = 1'b0;
endmodule
