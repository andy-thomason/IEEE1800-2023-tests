/*
:section: 5.7.2 Real literal constants
:summary: A real literal with a decimal point needs a digit before the point.
:type: parse
:should_fail_because: no digit before the decimal point
*/
module top;
  real r = .25;
endmodule
