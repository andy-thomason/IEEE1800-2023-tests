/*
:section: 17.7.2 Checker variable randomization with assumptions
:summary: Assume statements inside a checker constrain the random values chosen for its free
  variables.
*/
checker pick_chk (event clock, output bit [3:0] seen, output int violations);
  rand bit [3:0] choice;
  m1: assume property (@(clock) choice inside {[2:5]});
  always_ff @(clock) begin
    seen <= choice;
    if (!(choice inside {[2:5]})) violations <= violations + 1;
  end
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

  bit [3:0] seen;
  int violations = 0;
  pick_chk u(posedge clk, seen, violations);
  initial begin
    repeat (20) @(negedge clk);
    check(violations == 0, $sformatf("free variable violated its assumption %0d times", violations));
    check(seen inside {[2:5]}, "free variable value outside the assumed range");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
