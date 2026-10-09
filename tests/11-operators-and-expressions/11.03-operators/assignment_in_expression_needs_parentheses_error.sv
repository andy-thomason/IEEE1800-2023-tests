/*
:section: 11.3.6 Assignment within an expression
:summary: An assignment used inside an expression, such as an if condition, must be wrapped in
  parentheses.
:type: parse
:should_fail_because: an assignment is used as a condition without parentheses
*/
module top;
  int a, b;
  initial if (a = b) $display("same");
endmodule
