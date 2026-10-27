/*
:section: 16.14 Concurrent assertions
:summary: assert, assume and cover property statements run their pass or fail actions according
  to the property outcome.
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
  logic req = 0;
  string w_req = "0100100";
  logic gnt = 0;
  string w_gnt = "0010000";
  initial begin
    for (int i = 0; i <= 11; i++) begin
      if (i > 0) @(negedge clk);
      req = (i < w_req.len()) && (w_req[i] == "1");
      gnt = (i < w_gnt.len()) && (w_gnt[i] == "1");
    end
  end
  int a_fail = 0, u_fail = 0, c_pass = 0;
  a1: assert property (@(posedge clk) req |=> gnt) else a_fail++;
  u1: assume property (@(posedge clk) req |=> gnt) else u_fail++;
  c1: cover property (@(posedge clk) req ##1 gnt) c_pass++;
  initial begin
    #112;
    check(a_fail == 1 && u_fail == 1, $sformatf("assert %0d / assume %0d failures", a_fail, u_fail));
    check(c_pass == 1, $sformatf("cover %0d", c_pass));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
