/*
:section: 17.2 Checker declaration
:summary: A checker can hold concurrent assertions, and its formal arguments may carry input or
  output directions.
*/
checker req_gnt (logic req, logic gnt, event clock, output int fails);
  int count = 0;
  always_ff @(clock) fails <= count;
  a1: assert property (@(clock) req |=> gnt) else count++;
endchecker

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

  logic req = 0, gnt = 0;
  int fails;
  req_gnt u_chk(req, gnt, posedge clk, fails);
  initial begin
    @(negedge clk) req = 1;
    @(negedge clk) req = 0; gnt = 1;
    @(negedge clk) req = 1; gnt = 0;
    @(negedge clk) req = 0;
    repeat (3) @(negedge clk);
    check(fails == 1, $sformatf("checker reported %0d failures, expected 1", fails));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
