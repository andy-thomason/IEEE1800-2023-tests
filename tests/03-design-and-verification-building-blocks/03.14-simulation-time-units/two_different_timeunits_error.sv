/*
:section: 3.14.2.2 The timeunit and timeprecision keywords
:summary: A module must not declare two different time units.
:type: elaboration
:should_fail_because: the module declares two different time units
*/
module top;
  timeunit 1ns;
  timeunit 10ns;
  timeprecision 1ns;
endmodule
