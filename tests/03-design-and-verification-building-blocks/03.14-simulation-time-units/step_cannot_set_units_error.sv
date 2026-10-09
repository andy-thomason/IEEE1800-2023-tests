/*
:section: 3.14.3 Simulation time unit
:summary: The step unit cannot be used to specify a timeunit or timeprecision.
:type: parse
:should_fail_because: 1step cannot be used as a time unit
*/
module top;
  timeunit 1step;
endmodule
