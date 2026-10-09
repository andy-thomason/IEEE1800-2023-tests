/*
:section: 25.9 Virtual interfaces
:summary: Members reached through a virtual interface may not be used in a continuous
  assignment.
:type: elaboration
:should_fail_because: a virtual interface component is read in a continuous assignment
*/
interface sig_if(input logic clk);
  logic [7:0] value;
  logic flag;
  modport mon(input value);
endinterface

module top;
  logic clk;
  sig_if a(.clk(clk));
  virtual sig_if v = a;
  wire [7:0] w;
  assign w = v.value;
endmodule
