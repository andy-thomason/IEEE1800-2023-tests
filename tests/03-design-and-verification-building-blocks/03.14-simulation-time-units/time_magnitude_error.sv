/*
:section: 3.14 Simulation time units and precision
:summary: A time unit magnitude must be 1, 10 or 100, so 5ns is illegal.
:type: parse
:should_fail_because: 5 is not an order of magnitude of 1, 10 or 100
*/
module top;
  timeunit 5ns;
  timeprecision 1ns;
endmodule
