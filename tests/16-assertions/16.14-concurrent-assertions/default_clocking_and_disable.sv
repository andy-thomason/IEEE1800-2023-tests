/*
:section: 16.15 Disable iff resolution
:summary: Default clocking and default disable iff supply the clock and reset condition for
  assertions in their scope.
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
  string w_b = "0010000";
  logic rst = 0;
  string w_rst = "00001";
  initial begin
    for (int i = 0; i <= 11; i++) begin
      if (i > 0) @(negedge clk);
      a = (i < w_a.len()) && (w_a[i] == "1");
      b = (i < w_b.len()) && (w_b[i] == "1");
      rst = (i < w_rst.len()) && (w_rst[i] == "1");
    end
  end
  int fails = 0, fails_no_disable = 0;
  default clocking cb @(posedge clk); endclocking
  default disable iff (rst);
  a1: assert property (a |=> b) else fails++;
  a2: assert property (disable iff (1'b0) a |=> b) else fails_no_disable++;
  initial begin
    #112;
    check(fails == 0, $sformatf("default disable iff: %0d failures", fails));
    check(fails_no_disable == 1, $sformatf("explicit disable iff overrides the default: %0d", fails_no_disable));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
