/*
:section: 14.11 Cycle delay: ##
:summary: ##0 suspends until the clocking event when that event has not happened yet during this
  time step.
*/
module top;
  timeunit 1ns; timeprecision 1ns;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk = 0;
  always #5 clk = ~clk;
  default clocking cb @(posedge clk); endclocking
  initial begin
    #3;
    ##0;
    check($time == 5, "##0 before the event did not wait for it");
    ##0;
    check($time == 5, "##0 after the event in the same time step suspended");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
