/*
:section: 16.14.3 Cover statement
:summary: A cover property statement must not have an else clause, since cover has no failure
  action.
:type: parse
:should_fail_because: a cover statement has an else clause
*/
module top;
  logic clk, a;
  int f;
  c1: cover property (@(posedge clk) a) ; else f++;
endmodule
