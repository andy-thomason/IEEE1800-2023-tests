/*
:section: 12.7.3 The foreach-loop
:summary: A foreach loop may not list more index variables than the array has dimensions.
:type: elaboration
:should_fail_because: two loop variables for a one-dimensional array
*/
module top;
  int a [4];
  initial foreach (a[i, j]) ;
endmodule
