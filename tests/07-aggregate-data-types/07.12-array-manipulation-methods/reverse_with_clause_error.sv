/*
:section: 7.12.2 Array ordering methods
:summary: Supplying a with clause to the reverse() ordering method is a compile-time error.
:type: elaboration
:should_fail_because: reverse has a with clause
*/
module top;
  int q [$] = {1, 2, 3};
  initial q.reverse with (item);
endmodule
