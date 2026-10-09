/*
:section: 10.9.1 Array assignment patterns
:summary: A positional array assignment pattern must supply exactly one value for each element.
:type: elaboration
:should_fail_because: three expressions for a four-element array
*/
module top;
  int a [4];
  initial a = '{1, 2, 3};
endmodule
