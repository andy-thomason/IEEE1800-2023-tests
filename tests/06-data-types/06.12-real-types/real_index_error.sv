/*
:section: 6.12 Real, shortreal, and realtime data types
:summary: A real value used as a bit-select index is illegal.
:type: elaboration
:should_fail_because: a real index in a bit-select is prohibited
*/
  module top;
    real idx = 1.0;
logic [3:0] v = 4'b0101;
logic b;
initial b = v[idx];
  endmodule
