/*
:section: 7.7 Arrays as arguments to subroutines
:summary: An array actual must match the formal argument's size in every fixed dimension.
:type: elaboration
:should_fail_because: the second dimension has size 4, not 3
*/
module top;
  function automatic void take(int f [3:1][3:1]);
  endfunction
  int m [3:1][4:1];
  initial take(m);
endmodule
