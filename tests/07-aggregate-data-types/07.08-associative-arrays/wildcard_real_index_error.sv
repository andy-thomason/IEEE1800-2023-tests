/*
:section: 7.8.1 Wildcard index type
:summary: A wildcard-indexed associative array cannot use a real value as an index.
:type: elaboration
:should_fail_because: a real is used to index a wildcard associative array
*/
module top;
  int any_key [*];
  real r = 1.5;
  initial any_key[r] = 1;
endmodule
