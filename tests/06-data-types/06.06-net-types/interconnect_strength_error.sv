/*
:section: 6.6.8 Generic interconnect
:summary: An interconnect net must not be declared with a drive strength.
:type: parse
:should_fail_because: an interconnect net has a drive strength
*/
module top;
  interconnect (strong0, strong1) link;
endmodule
