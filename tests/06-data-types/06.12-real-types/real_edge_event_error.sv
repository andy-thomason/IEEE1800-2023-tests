/*
:section: 6.12 Real, shortreal, and realtime data types
:summary: An edge event control such as posedge on a real variable is illegal.
:type: elaboration
:should_fail_because: posedge on a real variable is prohibited
*/
  module top;
    real r = 1.5;
initial @(posedge r) $display("edge");
  endmodule
