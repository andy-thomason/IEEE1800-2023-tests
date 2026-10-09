/*
:section: 16.17 Expect statement
:summary: The expect statement blocks the calling process until its property passes or fails.
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
  logic clk = 0, a = 0, b = 0;
  always #5 clk = ~clk;
  int passed = 0, failed = 0;
  int done_at;
  initial begin
    @(negedge clk) a = 1;
    @(negedge clk) a = 0; b = 1;
    @(negedge clk) b = 0;
  end
  initial begin
    @(negedge clk);
    expect (@(posedge clk) a ##1 b) passed++; else failed++;
    done_at = $time;
    check(passed == 1 && failed == 0, "expect did not pass");
    check(done_at == 25, $sformatf("expect returned at %0t, expected the second clock edge (25)", done_at));
    expect (@(posedge clk) a) passed++; else failed++;
    check(failed == 1, "expect did not fail");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
