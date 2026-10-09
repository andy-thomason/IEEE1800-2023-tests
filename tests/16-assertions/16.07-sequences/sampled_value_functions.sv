/*
:section: 16.9.3 Sampled value functions
:summary: $rose, $fell, $stable, $changed and $past compare sampled values between consecutive
  clock ticks.
:description: Sampled value functions in procedural code infer the clock from the always block
  (16.14.7).
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
  logic a = 0;
  string w_a = "0110011";
  initial begin
    for (int i = 0; i <= 11; i++) begin
      if (i > 0) @(negedge clk);
      a = (i < w_a.len()) && (w_a[i] == "1");
    end
  end
  int cyc = 0, rises = 0, falls = 0, stables = 0, changes = 0, past2 = 0;
  always @(posedge clk) begin
    if (cyc > 0) begin
      if ($rose(a)) rises++;
      if ($fell(a)) falls++;
      if ($stable(a)) stables++;
      if ($changed(a)) changes++;
    end
    if (cyc > 1 && $past(a, 2)) past2++;
    cyc++;
  end
  initial begin
    #112;
    check(rises == 2 && falls == 2, $sformatf("rises %0d falls %0d", rises, falls));
    check(changes == 4 && stables == cyc - 1 - 4, $sformatf("changes %0d stables %0d over %0d cycles", changes, stables, cyc));
    check(past2 == 4, $sformatf("$past(a,2) true %0d times", past2));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
