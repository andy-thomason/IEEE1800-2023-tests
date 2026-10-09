/*
:section: 7.8.4 Integral index
:summary: A real value cannot implicitly index an int-indexed associative array.
:type: elaboration
:should_fail_because: a real index is used with an int index type
*/
module top;
  int by_int [int];
  real r = 2.0;
  initial by_int[r] = 1;
endmodule
