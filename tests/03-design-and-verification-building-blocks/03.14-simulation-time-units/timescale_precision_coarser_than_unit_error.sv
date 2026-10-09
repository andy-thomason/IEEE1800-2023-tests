/*
:section: 3.14 Simulation time units and precision
:summary: In a `timescale directive the precision must not be coarser than the unit.
:type: parse
:should_fail_because: the `timescale precision 10us is coarser than its unit 1us
*/
`timescale 1us / 10us
module top;
endmodule
