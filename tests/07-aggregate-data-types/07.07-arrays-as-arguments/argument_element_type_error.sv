/*
:section: 7.7 Arrays as arguments to subroutines
:summary: An array actual whose element type is not equivalent to the formal's is illegal.
:type: elaboration
:should_fail_because: logic elements do not match int elements
*/
module top;
  function automatic void take(int f [3:1][3:1]);
  endfunction
  logic m [3:1][3:1];
  initial take(m);
endmodule
