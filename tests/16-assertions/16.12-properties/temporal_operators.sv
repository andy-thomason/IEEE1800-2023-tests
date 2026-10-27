/*
:section: 16.12.10 Nexttime property
:summary: nexttime, always, eventually, until and related temporal property operators check
  behaviour over future clock ticks.
:description: Each property has one passing attempt (cycle 0) and one failing attempt (cycle 10).
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
  logic st = 0;
  string w_st = "10000000001";
  logic a = 0;
  string w_a = "01000000000010";
  logic b = 0;
  string w_b = "01110000000101";
  logic c = 0;
  string w_c = "000100000000000100";
  logic d = 0;
  string w_d = "111000000011";
  logic e = 0;
  string w_e = "0001000000000100";
  initial begin
    for (int i = 0; i <= 22; i++) begin
      if (i > 0) @(negedge clk);
      st = (i < w_st.len()) && (w_st[i] == "1");
      a = (i < w_a.len()) && (w_a[i] == "1");
      b = (i < w_b.len()) && (w_b[i] == "1");
      c = (i < w_c.len()) && (w_c[i] == "1");
      d = (i < w_d.len()) && (w_d[i] == "1");
      e = (i < w_e.len()) && (w_e[i] == "1");
    end
  end
  int f_next = 0, f_next2 = 0, f_always = 0, f_event = 0, f_until = 0;
  a1: assert property (@(posedge clk) st |-> nexttime a) else f_next++;
  a2: assert property (@(posedge clk) st |-> nexttime [2] a) else f_next2++;
  a3: assert property (@(posedge clk) st |-> always [1:3] b) else f_always++;
  a4: assert property (@(posedge clk) st |-> s_eventually [2:4] c) else f_event++;
  a5: assert property (@(posedge clk) st |-> (d until e)) else f_until++;
  initial begin
    #222;
    check(f_next == 1 && f_next2 == 1, $sformatf("nexttime %0d, nexttime[2] %0d", f_next, f_next2));
    check(f_always == 1, $sformatf("always[1:3]: %0d", f_always));
    check(f_event == 1, $sformatf("s_eventually[2:4]: %0d", f_event));
    check(f_until == 1, $sformatf("until: %0d", f_until));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
