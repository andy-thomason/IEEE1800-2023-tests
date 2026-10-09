/*
:section: 25.9 Virtual interfaces
:summary: A virtual interface may not be declared as an item inside an interface.
:type: elaboration
:should_fail_because: a virtual interface is declared as an interface item
*/
interface sig_if(input logic clk);
  logic [7:0] value;
  logic flag;
  modport mon(input value);
endinterface

interface holder_if;
  virtual sig_if v;
endinterface
module top;
  holder_if h();
endmodule
