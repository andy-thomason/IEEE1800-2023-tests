/*
:section: 14.5 Hierarchical expressions
:summary: Clocking block signals may be bound to arbitrary expressions such as slices or
  concatenations under a new name.
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
  logic [7:0] bus = 8'hA5;
  clocking cb @(posedge clk);
    input low = bus[3:0];
    input both = {bus[7:4], bus[3:0]};
  endclocking
  initial begin
    @(cb);
    check(cb.low == 4'h5 && cb.both == 8'hA5, "renamed clocking signals from expressions");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
