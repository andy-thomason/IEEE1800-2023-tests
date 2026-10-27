/*
:section: 16.13.6 Sequence methods
:summary: A sequence's triggered method is true exactly at the time step where that sequence
  reaches its end.
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
  string w_a = "01";
  logic b = 0;
  string w_b = "001";
  logic c = 0;
  string w_c = "0010010";
  initial begin
    for (int i = 0; i <= 11; i++) begin
      if (i > 0) @(negedge clk);
      a = (i < w_a.len()) && (w_a[i] == "1");
      b = (i < w_b.len()) && (w_b[i] == "1");
      c = (i < w_c.len()) && (w_c[i] == "1");
    end
  end
  int fails = 0;
  sequence s_ab;
    @(posedge clk) a ##1 b;
  endsequence
  a1: assert property (@(posedge clk) c |-> s_ab.triggered) else fails++;
  initial begin
    #112;
    check(fails == 1, $sformatf("%0d failures, expected 1 (c at cycle 5 without an end point)", fails));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
