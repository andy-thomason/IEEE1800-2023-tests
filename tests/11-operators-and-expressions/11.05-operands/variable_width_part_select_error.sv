/*
:section: 11.5.1 Vector bit-select and part-select addressing
:summary: The width of an indexed part-select such as +: must be a constant expression.
:type: elaboration
:should_fail_because: the width of an indexed part-select is not constant
*/
module top;
  logic [15:0] v;
  int w = 4;
  logic [15:0] r;
  initial r = v[0 +: w];
endmodule
