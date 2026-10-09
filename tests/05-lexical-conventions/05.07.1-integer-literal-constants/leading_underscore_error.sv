/*
:section: 5.7.1 Integer literal constants
:summary: A numeric literal must not begin its digits with an underscore.
:type: parse
:should_fail_because: the hexadecimal digits begin with an underscore
*/
module top;
  logic [7:0] v = 8'h_A5;
endmodule
