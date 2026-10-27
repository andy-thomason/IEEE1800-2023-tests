/*
:section: 16.12.7 Implication
:summary: |-> checks the consequent on the same tick, |=> on the next, and no antecedent match
  passes vacuously.
:description: Waveforms: character k of each string is the value sampled at the k-th rising clock
  edge.
:flags-verilator: --coverage-user
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
  logic a = 0;
  string w_a = "0100100";
  logic b = 0;
  string w_b = "0100010";
  initial begin
    for (int i = 0; i <= 11; i++) begin
      if (i > 0) @(negedge clk);
      a = (i < w_a.len()) && (w_a[i] == "1");
      b = (i < w_b.len()) && (w_b[i] == "1");
    end
  end
  int f_ov = 0, f_nov = 0, cov = 0;
  a1: assert property (@(posedge clk) a |-> b) else f_ov++;
  a2: assert property (@(posedge clk) a |=> b) else f_nov++;
  c1: cover property (@(posedge clk) a |-> b) cov++;
  initial begin
    #112;
    check(f_ov == 1, $sformatf("|-> failures: %0d", f_ov));
    check(f_nov == 1, $sformatf("|=> failures: %0d", f_nov));
    check(cov == 1, $sformatf("cover counted %0d; vacuous successes do not count", cov));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
