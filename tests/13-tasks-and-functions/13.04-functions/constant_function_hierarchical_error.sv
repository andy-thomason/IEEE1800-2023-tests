/*
:section: 13.4.3 Constant functions
:summary: A function used in a constant expression may not contain hierarchical references.
:type: elaboration
:should_fail_because: a function with a hierarchical reference is used in a constant expression
*/
module top;
  int global_v = 3;
  function automatic int peek(int n); return n + top.global_v; endfunction
  localparam int P = peek(1);
endmodule
