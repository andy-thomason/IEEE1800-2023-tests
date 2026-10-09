/*
:section: 7.9.9 Associative array assignment
:summary: Associative arrays with differing index types cannot be assigned to one another.
:type: elaboration
:should_fail_because: associative arrays with different index types are assigned
*/
  module top;
    int src [string];
int dst [int];
initial dst = src;
  endmodule
