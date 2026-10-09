/*
:section: 12.7.3 The foreach-loop
:summary: Index variables of a foreach loop may not be assigned.
:type: elaboration
:should_fail_because: a foreach loop variable is assigned
*/
module top;
  int a [4];
  initial foreach (a[i]) i = 2;
endmodule
