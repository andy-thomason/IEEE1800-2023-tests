/*
:section: 25.9 Virtual interfaces
:summary: Virtual interfaces start null, can be assigned instances, compared, and passed to
  subroutines.
*/
interface sig_if(input logic clk);
  logic [7:0] value;
  logic flag;
  modport mon(input value);
endinterface

task automatic drive(virtual sig_if v, logic [7:0] x);
  v.value = x;
endtask

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk = 0;
  sig_if a(.clk(clk)), b(.clk(clk));
  virtual sig_if v, w;
  initial begin
    #1;
    check(v == null, "uninitialised virtual interface is null");
    v = a;
    w = b;
    check(v == a && v != w, "equality with an instance and another virtual interface");
    drive(v, 8'h11);
    drive(w, 8'h22);
    check(a.value == 8'h11 && b.value == 8'h22, "one task drove two instances");
    w = v;
    check(w == v, "assignment between virtual interfaces");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
