/*
:section: 17.7.1 Checker variable assignments
:summary: A free rand checker variable must not be driven by a continuous assignment.
:type: elaboration
:should_fail_because: a free checker variable has a continuous assignment
*/
checker free_chk (logic a);
  rand bit flag;
  assign flag = a;
endchecker
module top;
  logic a;
  free_chk u(a);
endmodule
