/*
:section: 3.14.2.3 Precedence of timeunit, timeprecision, and `timescale
:summary: Mixing design elements that specify time unit and precision with ones that do not is
  an error.
:type: elaboration
:should_fail_because: module timed specifies a time unit and precision but module top does not
*/
module timed;
  timeunit 1ns;
  timeprecision 1ps;
endmodule

module top;
  timed u_timed();
endmodule
