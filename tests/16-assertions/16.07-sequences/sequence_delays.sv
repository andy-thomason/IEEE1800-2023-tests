/*
:section: 16.7 Sequences
:summary: A ##n or ##[m:n] delay sets how many clock ticks later the next sequence element
  begins.
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
  string w_a = "1000100000";
  logic b = 0;
  string w_b = "0010010000";
  initial begin
    for (int i = 0; i <= 14; i++) begin
      if (i > 0) @(negedge clk);
      a = (i < w_a.len()) && (w_a[i] == "1");
      b = (i < w_b.len()) && (w_b[i] == "1");
    end
  end
  int s1 = 0, s2 = 0, s3 = 0, p3 = 0;
  c1: cover sequence (@(posedge clk) a ##2 b) s1++;
  c2: cover sequence (@(posedge clk) a ##[1:2] b) s2++;
  c3: cover sequence (@(posedge clk) a ##[2:$] b) s3++;
  c4: cover property (@(posedge clk) a ##[2:$] b) p3++;
  initial begin
    #142;
    check(s1 == 1, $sformatf("a ##2 b matched %0d times, expected 1", s1));
    check(s2 == 2, $sformatf("a ##[1:2] b matched %0d times, expected 2", s2));
    check(s3 == 2, $sformatf("a ##[2:$] b matched %0d times, expected 2 (cover sequence counts every match)", s3));
    check(p3 == 1, $sformatf("cover property counted %0d, expected 1 (once per attempt)", p3));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
