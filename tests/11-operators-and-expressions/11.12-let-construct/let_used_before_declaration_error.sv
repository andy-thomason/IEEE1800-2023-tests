/*
:section: 11.12 Let construct
:summary: A let must be declared earlier in its scope than any use of it.
:type: elaboration
:should_fail_because: a let is used before its declaration
*/
module top;
  int r;
  initial r = later(2);
  let later(x) = x * 2;
endmodule
