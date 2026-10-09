/*
:section: 13.4.3 Constant functions
:summary: A constant function may not read module-level variables when used in a constant
  expression.
:type: elaboration
:should_fail_because: a constant function reads a module variable
*/
module top;
  int counter = 4;
  function automatic int addc(int n); return n + counter; endfunction
  localparam int P = addc(1);
endmodule
