/*
:section: 25.9 Virtual interfaces
:summary: A virtual interface may only take an instance whose parameter values match its own.
:type: elaboration
:should_fail_because: a W=16 instance is assigned to a W=8 virtual interface
*/
interface w_if #(parameter int W = 8);
  logic [W-1:0] value;
endinterface
module top;
  w_if #(16) wide();
  virtual w_if #(8) v;
  initial v = wide;
endmodule
