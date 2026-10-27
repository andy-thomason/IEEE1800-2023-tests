/*
:section: 16.9.2 Repetition in sequences
:summary: Sequences support consecutive [*], goto [->] and nonconsecutive [=] repetition with
  differing end points.
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
  string w_a = "0111011000";
  logic b = 0;
  string w_b = "0101001000";
  logic st = 0;
  string w_st = "1";
  logic bb = 0;
  string w_bb = "0101";
  logic en = 0;
  string w_en = "000001";
  initial begin
    for (int i = 0; i <= 14; i++) begin
      if (i > 0) @(negedge clk);
      a = (i < w_a.len()) && (w_a[i] == "1");
      b = (i < w_b.len()) && (w_b[i] == "1");
      st = (i < w_st.len()) && (w_st[i] == "1");
      bb = (i < w_bb.len()) && (w_bb[i] == "1");
      en = (i < w_en.len()) && (w_en[i] == "1");
    end
  end
  int r3 = 0, r2 = 0, rr = 0, go = 0, eq = 0, gt = 0;
  cr3: cover sequence (@(posedge clk) a[*3]) r3++;
  cr2: cover sequence (@(posedge clk) a[*2]) r2++;
  crr: cover sequence (@(posedge clk) a[*1:2] ##1 !a) rr++;
  cgo: cover sequence (@(posedge clk) a ##1 b[->2]) go++;
  ceq: cover sequence (@(posedge clk) st ##1 bb[=2] ##1 en) eq++;
  cgt: cover sequence (@(posedge clk) st ##1 bb[->2] ##1 en) gt++;
  initial begin
    #142;
    check(r3 == 1, $sformatf("a[*3]: %0d", r3));
    check(r2 == 3, $sformatf("a[*2]: %0d", r2));
    check(rr == 4, $sformatf("a[*1:2] ##1 !a: %0d", rr));
    check(go == 2, $sformatf("a ##1 b[->2]: %0d", go));
    check(eq == 1, $sformatf("[=2] may end after the last b: %0d", eq));
    check(gt == 0, $sformatf("[->2] ends at the last b: %0d", gt));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
