/*
:section: 25.9 Virtual interfaces
:summary: A virtual interface may not be used as a module port.
:type: elaboration
:should_fail_because: a virtual interface is a module port
*/
interface sig_if(input logic clk);
  logic [7:0] value;
  logic flag;
  modport mon(input value);
endinterface

module user(virtual sig_if v); endmodule
module top; endmodule
