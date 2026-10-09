/*
:section: 11.2.1 Constant expressions
:summary: A variable cannot be used where a constant expression is required, such as a range
  bound.
:type: elaboration
:should_fail_because: a variable is used in a range, which needs a constant expression
*/
module top;
  int n = 4;
  logic [n:0] v;
endmodule
