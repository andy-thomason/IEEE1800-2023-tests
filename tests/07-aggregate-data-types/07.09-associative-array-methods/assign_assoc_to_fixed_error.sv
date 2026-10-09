/*
:section: 7.9.9 Associative array assignment
:summary: An associative array cannot be assigned to a fixed-size array.
:type: elaboration
:should_fail_because: an associative array is assigned to a fixed-size array
*/
  module top;
    int src [int];
int dst [4];
initial dst = src;
  endmodule
