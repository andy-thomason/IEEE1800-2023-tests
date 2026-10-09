/*
:section: 6.10 Implicit declarations
:summary: Under `default_nettype none an undeclared identifier does not create an implicit net.
:type: elaboration
:should_fail_because: with `default_nettype none there are no implicit nets
*/
`default_nettype none
module top;
  assign never_declared = 1'b1;
endmodule
`default_nettype wire
