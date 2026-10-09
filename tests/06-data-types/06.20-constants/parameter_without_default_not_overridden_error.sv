/*
:section: 6.20.1 Parameter declaration syntax
:summary: Instantiating a module without overriding a parameter that lacks a default is illegal.
:type: elaboration
:should_fail_because: the instance does not give a value for N, which has no default
*/
module needs_value #(parameter int N);
endmodule

module top;
  needs_value u();
endmodule
