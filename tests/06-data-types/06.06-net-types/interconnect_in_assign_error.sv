/*
:section: 6.6.8 Generic interconnect
:summary: An interconnect net must not be the target of a continuous assignment.
:type: elaboration
:should_fail_because: an interconnect net is the target of a continuous assignment
*/
  module top;
    interconnect link;
assign link = 1'b1;
  endmodule
