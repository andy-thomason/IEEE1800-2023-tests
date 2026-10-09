/*
:section: 25.9 Virtual interfaces
:summary: Dereferencing a virtual interface that is still null must abort simulation with a
  fatal error.
:type: simulation
:should_fail_because: the run dereferences a null virtual interface
*/
interface sig_if(input logic clk);
  logic [7:0] value;
  logic flag;
  modport mon(input value);
endinterface

module top;
  logic clk = 0;
  virtual sig_if v;
  initial begin
    v.value = 1;
    $display("PASS");
  end
endmodule
