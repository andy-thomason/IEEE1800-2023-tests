/*
:section: 25.9 Virtual interfaces
:summary: An interface instance targeted by a defparam may not be assigned to a virtual
  interface.
:type: elaboration
:should_fail_because: the assigned interface instance has a defparam
*/
interface w_if #(parameter int W = 8);
  logic [W-1:0] value;
endinterface
module top;
  w_if inst();
  defparam inst.W = 8;
  virtual w_if v;
  initial v = inst;
endmodule
