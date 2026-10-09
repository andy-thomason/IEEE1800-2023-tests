/*
:section: 6.24.1 Cast operator
:summary: A size cast with a width of zero is an error.
:type: elaboration
:should_fail_because: the cast size is zero
*/
module top;
  parameter int Z = 0;
  logic [3:0] v = 4'h5;
  logic [3:0] r;
  initial r = Z'(v);
endmodule
