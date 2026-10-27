/*
:section: 14.14 Global clocking
:summary: $global_clock refers to the clocking event of the global clocking declaration in
  scope.
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
  global clocking sys @(posedge clk); endclocking
  int ticks = 0;
  always @($global_clock) ticks++;
  initial begin
    #31;
    check(ticks == 3, $sformatf("$global_clock fired %0d times by t=31", ticks));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
