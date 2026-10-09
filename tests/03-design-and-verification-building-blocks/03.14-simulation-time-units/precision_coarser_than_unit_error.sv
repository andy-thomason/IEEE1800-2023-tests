/*
:section: 3.14 Simulation time units and precision
:summary: A timeprecision coarser than the corresponding timeunit is illegal.
:type: elaboration
:should_fail_because: the precision 10ns is coarser than the unit 1ns
*/
module top;
  timeunit 1ns;
  timeprecision 10ns;
endmodule
