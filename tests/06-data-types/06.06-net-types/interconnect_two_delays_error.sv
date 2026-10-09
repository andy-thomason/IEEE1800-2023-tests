/*
:section: 6.6.8 Generic interconnect
:summary: An interconnect net must not specify more than a single delay.
:type: parse
:should_fail_because: an interconnect net has more than one delay
*/
module top;
  interconnect #(4, 5) link;
endmodule
