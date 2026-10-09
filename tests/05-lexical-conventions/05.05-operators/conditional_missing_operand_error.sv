/*
:section: 5.5 Operators
:summary: The ?: conditional operator requires three operands; omitting the false branch is
  illegal.
:type: parse
:should_fail_because: the conditional operator has only two operands
*/
module top;
  int a = 3, r;
  bit c = 1;
  initial r = c ? a;
endmodule
