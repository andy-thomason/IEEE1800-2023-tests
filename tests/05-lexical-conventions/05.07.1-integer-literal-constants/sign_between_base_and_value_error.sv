/*
:section: 5.7.1 Integer literal constants
:summary: A sign placed between the base specifier and the digits of a literal is illegal.
:type: parse
:should_fail_because: a minus sign sits between the base and the digits
*/
module top;
  logic [7:0] v = 8'h -1F;
endmodule
