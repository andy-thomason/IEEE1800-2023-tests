/*
:section: 16.5.1 Sampling
:summary: Concurrent assertions evaluate expressions using values taken from the Preponed region
  at each clock tick.
:description: a changes to 1 at the first of five rising edges; that edge must still sample 0, so
  only the 4 later edges fail.
:flags-verilator: --coverage-user
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
  initial begin
    for (int i = 0; i <= 5; i++) begin
      if (i > 0) @(negedge clk);
    end
  end
  logic a = 0;
  int fails = 0;
  initial @(posedge clk) a <= 1;
  ap: assert property (@(posedge clk) a == 0) else fails++;
  initial begin
    #52;
    check(fails == 4, $sformatf("%0d failures; the first edge should use the value sampled before a changed", fails));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
