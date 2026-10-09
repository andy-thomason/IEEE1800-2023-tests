/*
:section: 13.5.4 Argument binding by name
:summary: A positional argument may not appear after a named argument in a call.
:type: parse
:should_fail_because: a positional argument follows a named one
*/
module top;
  function automatic int f(int a = 1, int b = 2); return a + b; endfunction
  int r;
  initial r = f(.a(3), 4);
endmodule
