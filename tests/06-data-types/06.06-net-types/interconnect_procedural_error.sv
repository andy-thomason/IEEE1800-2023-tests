/*
:section: 6.6.8 Generic interconnect
:summary: An interconnect net must not be referenced in a procedural context.
:type: elaboration
:should_fail_because: an interconnect net is used in a procedural context
*/
  module top;
    interconnect link;
initial $display("%b", link);
  endmodule
