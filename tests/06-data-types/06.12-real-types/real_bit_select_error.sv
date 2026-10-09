/*
:section: 6.12 Real, shortreal, and realtime data types
:summary: A bit-select applied to a real variable is illegal.
:type: elaboration
:should_fail_because: a bit-select of a real variable is prohibited
*/
  module top;
    real r = 1.5;
bit b;
initial b = r[0];
  endmodule
