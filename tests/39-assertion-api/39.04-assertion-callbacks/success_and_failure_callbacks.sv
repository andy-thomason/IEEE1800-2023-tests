/*
:section: 39.4.2 Placing assertions callbacks
:summary: Assertion callbacks registered for success and failure fire on each passing or failing
  attempt.
:vpi: success_and_failure_callbacks.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk = 0, v = 1;
  int successes, failures;
  a_check: assert property (@(posedge clk) v) else ;
  initial begin
    $t_arm_assertion_cbs;
    repeat (3) begin #5 clk = 1; #5 clk = 0; end
    v = 0;
    repeat (2) begin #5 clk = 1; #5 clk = 0; end
    #1 $t_assertion_counts(successes, failures);
    check(successes == 3, $sformatf("success callbacks: %0d", successes));
    check(failures == 2, $sformatf("failure callbacks: %0d", failures));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
