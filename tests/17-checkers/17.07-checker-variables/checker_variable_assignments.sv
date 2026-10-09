/*
:section: 17.7.1 Checker variable assignments
:summary: Checker variables may be driven by always_ff nonblocking assignments and by continuous
  assignments inside the checker.
*/
checker counter_chk (logic tick, event clock, output int total);
  int n = 0;
  always_ff @(clock) if (tick) n <= n + 1;
  assign total = n;
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

  logic t = 0;
  int total;
  counter_chk u(t, posedge clk, total);
  initial begin
    @(negedge clk) t = 1;
    repeat (3) @(negedge clk);
    t = 0;
    @(negedge clk);
    check(total == 3, $sformatf("checker counted %0d ticks, expected 3", total));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
