/*
:section: 3.14.2.2 The timeunit and timeprecision keywords
:summary: A later timeprecision declaration that differs from the earlier one in the same scope
  is illegal.
:type: elaboration
:should_fail_because: the repeated timeprecision does not match the first
*/
module top;
  timeunit 1ns;
  timeprecision 1ps;
  logic flag;
  timeprecision 10ps;
endmodule
