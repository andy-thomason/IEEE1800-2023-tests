/*
:section: 5.7.2 Real literal constants
:summary: A real literal with a decimal point needs a digit after the point.
:type: parse
:should_fail_because: no digit after the decimal point
*/
module top;
  real r = 3.;
endmodule
