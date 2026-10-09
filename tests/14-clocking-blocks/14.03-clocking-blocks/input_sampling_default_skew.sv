/*
:section: 14.13 Input sampling
:summary: With the default input skew, clocking inputs capture the value from just before the
  clocking event.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  timeunit 1ns; timeprecision 1ns;
  logic clk = 0;
  always #5 clk = ~clk;
  logic [3:0] d = 0;
  clocking cb @(posedge clk);
    input d;
  endclocking
  always @(posedge clk) d <= d + 1;
  initial begin
    @(cb);
    check(cb.d == 0 && d == 1, $sformatf("first edge: sampled %0d, signal %0d", cb.d, d));
    @(cb);
    check(cb.d == 1 && d == 2, $sformatf("second edge: sampled %0d (the value before the edge)", cb.d));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
