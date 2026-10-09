/*
:section: 7.7 Arrays as arguments to subroutines
:summary: An array actual must have the same number of dimensions as the array formal argument.
:type: elaboration
:should_fail_because: the actual has one dimension, the formal two
*/
module top;
  function automatic void take(int f [3:1][3:1]);
  endfunction
  int m [3:1];
  initial take(m);
endmodule
