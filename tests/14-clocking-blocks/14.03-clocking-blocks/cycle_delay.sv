/*
:section: 14.11 Cycle delay: ##
:summary: ## delays execution by the given number of default clocking cycles.
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
  default clocking cb @(posedge clk); endclocking
  int j = 2;
  initial begin
    ##1;
    check($time == 5, $sformatf("##1 from time 0 ended at %0t", $time));
    ##3;
    check($time == 35, $sformatf("##3 ended at %0t", $time));
    ##(j + 1);
    check($time == 65, $sformatf("##(j+1) ended at %0t", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
