/*
:section: 16.12.9 Followed-by property
:summary: The #-# and #=# operators require the sequence to match, then check the property
  overlapped or one tick later.
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
  string w_b = "0100010";
  initial begin
    for (int i = 0; i <= 11; i++) begin
      if (i > 0) @(negedge clk);
      a = (i < w_a.len()) && (w_a[i] == "1");
      b = (i < w_b.len()) && (w_b[i] == "1");
    end
  end
  int ov = 0, nov = 0;
  c1: cover property (@(posedge clk) a #-# b) ov++;
  c2: cover property (@(posedge clk) a #=# b) nov++;
  initial begin
    #112;
    check(ov == 1, $sformatf("#-# covered %0d", ov));
    check(nov == 1, $sformatf("#=# covered %0d", nov));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
