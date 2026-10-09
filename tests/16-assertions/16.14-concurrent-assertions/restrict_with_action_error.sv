/*
:section: 16.14.4 Restrict statement
:summary: A restrict property statement must not be followed by an action statement.
:type: parse
:should_fail_because: a restrict statement has an action block
*/
module top;
  logic clk, a;
  int f;
  r1: restrict property (@(posedge clk) a) f++;
endmodule
