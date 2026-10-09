/*
:section: 3.14.2.2 The timeunit and timeprecision keywords
:summary: The first timeunit or timeprecision declaration must come before every other item in
  its scope.
:type: elaboration
:should_fail_because: the first timeunit declaration follows another item
*/
module top;
  logic early_item;
  timeunit 1ns;
  timeprecision 1ps;
endmodule
