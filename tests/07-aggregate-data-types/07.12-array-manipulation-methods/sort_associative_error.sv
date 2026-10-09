/*
:section: 7.12.2 Array ordering methods
:summary: Ordering methods such as sort() may not be applied to an associative array.
:type: elaboration
:should_fail_because: sort is called on an associative array
*/
module top;
  int m [int];
  initial m.sort();
endmodule
