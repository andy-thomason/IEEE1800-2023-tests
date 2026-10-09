/*
:section: 16.11 Calling subroutines on match of a sequence
:summary: Tasks and functions listed after a sequence's Boolean expression run when that
  sequence matches.
:description: Waveforms: character k of each string is the value sampled at the k-th rising clock
  edge.
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
  string w_a = "0100100";
  logic b = 0;
  string w_b = "0010000";
  initial begin
    for (int i = 0; i <= 11; i++) begin
      if (i > 0) @(negedge clk);
      a = (i < w_a.len()) && (w_a[i] == "1");
      b = (i < w_b.len()) && (w_b[i] == "1");
    end
  end
  int first_calls = 0, second_calls = 0;
  function void note(int k);
    if (k == 1) first_calls++; else second_calls++;
  endfunction
  c1: cover sequence (@(posedge clk) (a, note(1)) ##1 (b, note(2)));
  initial begin
    #112;
    check(first_calls == 2, $sformatf("calls after a: %0d", first_calls));
    check(second_calls == 1, $sformatf("calls after b: %0d", second_calls));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
