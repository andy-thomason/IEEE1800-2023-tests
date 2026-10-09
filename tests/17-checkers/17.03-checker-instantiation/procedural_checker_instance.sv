/*
:section: 17.3 Checker instantiation
:summary: A checker instantiated within procedural code acts as a procedural checker and can
  infer its clock.
*/
checker stays_high (logic sig, event clock = $inferred_clock, output bit seen_low);
  always_ff @(clock) seen_low <= seen_low | !sig;
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

  logic s = 1;
  bit low_static, low_proc;
  stays_high u_static(s, posedge clk, low_static);
  always @(posedge clk) begin
    stays_high u_proc(s, , low_proc);
  end
  initial begin
    repeat (2) @(negedge clk);
    s = 0;
    @(negedge clk) s = 1;
    repeat (2) @(negedge clk);
    check(low_static && low_proc, "checkers did not observe the low cycle");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
