/*
:section: 5.11 Array literals
:summary: A multidimensional array must not be initialised from a single flat brace list.
:type: elaboration
:should_fail_because: a two-dimensional array is initialised with a flat list
*/
module top;
  int grid [0:1][0:1] = '{1, 2, 3, 4};
endmodule
