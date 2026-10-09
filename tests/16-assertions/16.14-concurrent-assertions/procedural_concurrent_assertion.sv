/*
:section: 16.14.6 Embedding concurrent assertions in procedural code
:summary: A concurrent assertion inside an always procedure infers its clock and uses the
  reaching condition as an antecedent.
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
  logic en = 0;
  string w_en = "0110000";
  logic a = 0;
  string w_a = "0110100";
  logic b = 0;
  string w_b = "0010010";
  initial begin
    for (int i = 0; i <= 11; i++) begin
      if (i > 0) @(negedge clk);
      en = (i < w_en.len()) && (w_en[i] == "1");
      a = (i < w_a.len()) && (w_a[i] == "1");
      b = (i < w_b.len()) && (w_b[i] == "1");
    end
  end
  int fails = 0;
  always @(posedge clk) begin
    if (en)
      ap: assert property (a |=> b) else fails++;
  end
  initial begin
    #112;
    check(fails == 1, $sformatf("%0d failures, expected 1 (only the enabled attempt at cycle 2 fails)", fails));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
