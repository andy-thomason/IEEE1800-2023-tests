/*
:section: 23.10.2 Module instance parameter value assignment
:summary: One instance cannot combine positional and named parameter overrides; choose a single
  style.
:type: parse
:should_fail_because: ordered and named parameter assignments are mixed
*/
module m #(parameter int A = 1, B = 2); endmodule
module top;
  m #(5, .B(6)) u();
endmodule
