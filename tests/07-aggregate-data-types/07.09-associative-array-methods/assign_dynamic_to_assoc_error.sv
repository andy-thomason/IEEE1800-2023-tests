/*
:section: 7.9.9 Associative array assignment
:summary: Assigning a dynamic array to an associative array variable is illegal.
:type: elaboration
:should_fail_because: a dynamic array is assigned to an associative array
*/
  module top;
    int src [];
int dst [int];
initial dst = src;
  endmodule
