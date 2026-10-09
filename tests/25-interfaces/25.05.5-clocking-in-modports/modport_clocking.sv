/*
:section: 25.5.5 Clocking blocks and modports
:summary: A modport can list a clocking block, giving clocking signal directions to the
  connected module.
*/
interface sync_if(input logic clk);
  logic [3:0] d;
  clocking cb @(posedge clk);
    output d;
  endclocking
  modport drv(clocking cb);
endinterface
module driver(sync_if.drv p);
  initial begin
    @(p.cb);
    p.cb.d <= 4'h6;
  end
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk = 0;
  sync_if s(.clk(clk));
  driver d(.p(s));
  initial begin
    #1;
    repeat (3) begin #5 clk = 1; #5 clk = 0; end
    check(s.d == 4'h6, $sformatf("clocking drive through the modport gave %h", s.d));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
