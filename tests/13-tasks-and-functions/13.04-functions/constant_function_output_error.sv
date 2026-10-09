/*
:section: 13.4.3 Constant functions
:summary: A function with an output argument cannot be called as a constant function.
:type: elaboration
:should_fail_because: a function with an output argument is used as a constant function
*/
module top;
  function automatic int two(input int n, output int m); m = n; return n; endfunction
  int tmp;
  localparam int P = two(1, tmp);
endmodule
