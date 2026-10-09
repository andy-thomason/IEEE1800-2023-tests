/*
:section: 16.12.14 Abort properties
:summary: accept_on and reject_on abort a property evaluation when their condition becomes true.
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
  logic st = 0;
  string w_st = "0100010001";
  logic ok = 0;
  string w_ok = "0001";
  logic rst = 0;
  string w_rst = "0000001";
  logic acc = 0;
  string w_acc = "00000000001";
  logic rej = 0;
  string w_rej = "001";
  initial begin
    for (int i = 0; i <= 15; i++) begin
      if (i > 0) @(negedge clk);
      st = (i < w_st.len()) && (w_st[i] == "1");
      ok = (i < w_ok.len()) && (w_ok[i] == "1");
      rst = (i < w_rst.len()) && (w_rst[i] == "1");
      acc = (i < w_acc.len()) && (w_acc[i] == "1");
      rej = (i < w_rej.len()) && (w_rej[i] == "1");
    end
  end
  int f_dis = 0, f_acc = 0, f_rej = 0;
  a1: assert property (@(posedge clk) disable iff (rst) st |-> ##2 ok) else f_dis++;
  a2: assert property (@(posedge clk) accept_on (acc) (st |-> ##2 ok)) else f_acc++;
  a3: assert property (@(posedge clk) reject_on (rej) (st |-> ##2 ok)) else f_rej++;
  initial begin
    #152;
    check(f_dis == 1, $sformatf("disable iff: %0d failures", f_dis));
    check(f_acc == 1, $sformatf("accept_on: %0d failures", f_acc));
    check(f_rej == 4, $sformatf("reject_on: %0d failures (attempts 1, 2, 5 and 9)", f_rej));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
