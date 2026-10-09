/*
:section: 14.12 Default clocking
:summary: A previously declared clocking block can be made the default by naming it in a default
  clocking statement.
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
  clocking slow @(negedge clk); endclocking
  default clocking slow;
  initial begin
    ##2;
    check($time == 20, $sformatf("##2 on negedges from 0 ended at %0t", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
