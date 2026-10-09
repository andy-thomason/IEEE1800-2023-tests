/*
:section: 6.24.1 Cast operator
:summary: A size cast with a negative width is an error.
:type: elaboration
:should_fail_because: the cast size is negative
*/
module top;
  parameter int N = -2;
  logic [3:0] v = 4'h5;
  logic [3:0] r;
  initial r = N'(v);
endmodule
