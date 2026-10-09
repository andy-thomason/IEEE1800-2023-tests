/*
:section: 22.7 `timescale
:summary: Placing `timescale inside a module or other design element is illegal.
:type: parse
:should_fail_because: `timescale appears inside a module
*/
module top;
`timescale 1ns / 1ps
endmodule
