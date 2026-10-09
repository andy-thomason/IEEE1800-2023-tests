/*
:section: 5.7.2 Real literal constants
:summary: In exponent form, a real literal still needs a digit between the point and the e.
:type: parse
:should_fail_because: no digit between the decimal point and the exponent
*/
module top;
  real r = 6.e2;
endmodule
