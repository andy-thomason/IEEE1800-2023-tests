/*
:section: 23.10.1 defparam statement
:summary: A defparam value must be a constant built from numbers and parameters, not a variable.
:type: elaboration
:should_fail_because: a defparam assigns a variable
*/
module m #(parameter int A = 1); endmodule
module top;
  int v = 3;
  m u();
  defparam u.A = v;
endmodule
