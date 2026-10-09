/*
:section: 25.9 Virtual interfaces
:summary: A class property can hold a virtual interface, set procedurally or through a new()
  argument.
:description: 25.9.1: the clocking block is reached through the virtual interface.
*/
interface sig_if(input logic clk);
  logic [7:0] value;
  logic flag;
  clocking cb @(posedge clk);
    output value;
  endclocking
  modport mon(input value);
endinterface

class Driver;
  virtual sig_if vif;
  function new(virtual sig_if v); vif = v; endfunction
  task send(logic [7:0] x);
    vif.cb.value <= x;
    @(vif.cb);
  endtask
endclass

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk = 0;
  always #5 clk = ~clk;
  sig_if a(.clk(clk));
  Driver d = new(a);
  initial begin
    #1;
    d.send(8'h5A);
    @(posedge clk);
    check(a.value == 8'h5A, $sformatf("clocking drive through a virtual interface in a class gave %h", a.value));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
