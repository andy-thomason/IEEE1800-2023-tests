/*
:section: 11.5.1 Vector bit-select and part-select addressing
:summary: Selecting a bit from a scalar variable is illegal.
:type: elaboration
:should_fail_because: a bit-select of a scalar
*/
module top;
  logic scalar;
  logic r;
  initial r = scalar[0];
endmodule
