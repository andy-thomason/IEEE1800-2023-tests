/*
:section: 10.3.2 The continuous assignment statement
:summary: A variable must be declared before any continuous assignment drives it.
:type: elaboration
:should_fail_because: a variable is declared after the continuous assignment to it
*/
module top;
  assign late_var = 1'b1;
  logic late_var;
endmodule
