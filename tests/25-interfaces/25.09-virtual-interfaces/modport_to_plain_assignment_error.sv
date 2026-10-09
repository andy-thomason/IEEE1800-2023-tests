/*
:section: 25.9.2 Virtual interface modports and clocking blocks
:summary: A modport-qualified virtual interface may not be assigned to one without a modport.
:type: elaboration
:should_fail_because: a modport-qualified virtual interface is assigned to an unqualified one
*/
interface sig_if(input logic clk);
  logic [7:0] value;
  logic flag;
  modport mon(input value);
endinterface

module top;
  logic clk;
  sig_if a(.clk(clk));
  virtual sig_if.mon m;
  virtual sig_if plain;
  initial begin
    m = a;
    plain = m;
  end
endmodule
