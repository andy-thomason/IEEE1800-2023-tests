/*
:section: 10.9.1 Array assignment patterns
:summary: An array assignment pattern must not specify the same index key twice.
:type: elaboration
:should_fail_because: index 1 appears twice in one pattern
*/
module top;
  int a [4];
  initial a = '{1: 5, 1: 6, default: 0};
endmodule
