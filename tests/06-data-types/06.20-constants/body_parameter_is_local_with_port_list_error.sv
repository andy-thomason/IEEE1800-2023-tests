/*
:section: 6.20.1 Parameter declaration syntax
:summary: With a parameter port list, body parameters become local and cannot be overridden by
  instances.
:type: elaboration
:should_fail_because: B is a local parameter because the module has a parameter port list
*/
module holder #(parameter int A = 1);
  parameter int B = 2;
endmodule

module top;
  holder #(.A(5), .B(6)) u();
endmodule
