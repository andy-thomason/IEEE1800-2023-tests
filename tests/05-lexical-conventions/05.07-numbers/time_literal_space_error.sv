/*
:section: 5.7 Numbers
:summary: A time literal must have no white space between its number and unit.
:type: parse
:should_fail_because: the time unit is separated from its number by a space
*/
module top;
  timeunit 1ns;
  timeprecision 1ps;
  realtime t = 25 ps;
endmodule
