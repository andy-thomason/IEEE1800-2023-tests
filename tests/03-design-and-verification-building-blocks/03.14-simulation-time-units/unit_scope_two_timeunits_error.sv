/*
:section: 3.14.2.2 The timeunit and timeprecision keywords
:summary: The compilation-unit scope must not declare two different time units.
:type: elaboration
:should_fail_because: the compilation-unit scope declares two different time units
*/
timeunit 1ns;
timeunit 1us;
timeprecision 1ns;

module top;
endmodule
