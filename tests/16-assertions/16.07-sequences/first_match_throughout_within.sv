/*
:section: 16.9.8 First_match operation
:summary: first_match keeps only the earliest match, throughout requires a condition during a
  sequence, and within nests sequences.
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
  string w_b = "011";
  logic p = 0;
  string w_p = "100001";
  logic q = 0;
  string w_q = "001000010";
  logic en = 0;
  string w_en = "1110010111";
  logic r = 0;
  string w_r = "01";
  logic s = 0;
  string w_s = "001";
  logic u = 0;
  string w_u = "1";
  logic v = 0;
  string w_v = "00001";
  initial begin
    for (int i = 0; i <= 14; i++) begin
      if (i > 0) @(negedge clk);
      a = (i < w_a.len()) && (w_a[i] == "1");
      b = (i < w_b.len()) && (w_b[i] == "1");
      p = (i < w_p.len()) && (w_p[i] == "1");
      q = (i < w_q.len()) && (w_q[i] == "1");
      en = (i < w_en.len()) && (w_en[i] == "1");
      r = (i < w_r.len()) && (w_r[i] == "1");
      s = (i < w_s.len()) && (w_s[i] == "1");
      u = (i < w_u.len()) && (w_u[i] == "1");
      v = (i < w_v.len()) && (w_v[i] == "1");
    end
  end
  int plain = 0, first = 0, thr = 0, thr_plain = 0, win = 0;
  c1: cover sequence (@(posedge clk) a ##[1:3] b) plain++;
  c2: cover sequence (@(posedge clk) first_match(a ##[1:3] b)) first++;
  c3: cover sequence (@(posedge clk) en throughout (p ##2 q)) thr++;
  c4: cover sequence (@(posedge clk) p ##2 q) thr_plain++;
  c5: cover sequence (@(posedge clk) (r ##1 s) within (u ##4 v)) win++;
  initial begin
    #142;
    check(plain == 2 && first == 1, $sformatf("plain %0d, first_match %0d", plain, first));
    check(thr_plain == 2 && thr == 1, $sformatf("without throughout %0d, with %0d", thr_plain, thr));
    check(win == 1, $sformatf("within: %0d", win));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
