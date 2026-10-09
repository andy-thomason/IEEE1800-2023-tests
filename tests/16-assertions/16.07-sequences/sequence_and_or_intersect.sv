/*
:section: 16.9.5 AND operation
:summary: Sequence and, or and intersect combine operand matches with rules for start and end
  times.
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
  string w_a = "1";
  logic b = 0;
  string w_b = "01";
  logic c = 0;
  string w_c = "001";
  initial begin
    for (int i = 0; i <= 7; i++) begin
      if (i > 0) @(negedge clk);
      a = (i < w_a.len()) && (w_a[i] == "1");
      b = (i < w_b.len()) && (w_b[i] == "1");
      c = (i < w_c.len()) && (w_c[i] == "1");
    end
  end
  int n_and = 0, n_isect = 0, n_or = 0, n_isect2 = 0;
  c1: cover sequence (@(posedge clk) (a ##1 b) and (a ##2 c)) n_and++;
  c2: cover sequence (@(posedge clk) (a ##1 b) intersect (a ##2 c)) n_isect++;
  c3: cover sequence (@(posedge clk) (a ##1 b) or (a ##2 c)) n_or++;
  c4: cover sequence (@(posedge clk) (a ##[1:2] 1'b1) intersect (a ##2 c)) n_isect2++;
  initial begin
    #72;
    check(n_and == 1, $sformatf("and: %0d", n_and));
    check(n_isect == 0, $sformatf("intersect of different lengths: %0d", n_isect));
    check(n_or == 2, $sformatf("or: %0d", n_or));
    check(n_isect2 == 1, $sformatf("intersect with a range: %0d", n_isect2));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
