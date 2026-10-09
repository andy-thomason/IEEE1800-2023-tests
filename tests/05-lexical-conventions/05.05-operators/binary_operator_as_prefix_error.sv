/*
:section: 5.5 Operators
:summary: A binary operator such as multiplication cannot be used with only a right-hand
  operand.
:type: parse
:should_fail_because: * is a binary operator and has no left operand
*/
module top;
  int a = 3, r;
  initial r = * a;
endmodule
