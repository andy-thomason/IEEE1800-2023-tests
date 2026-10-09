/*
:section: 4.4.2.3 Inactive events region
:summary: A #0 delay suspends the process until other active blocking work completes but before
  nonblocking updates.
:description: The writer has no time controls, so all of its blocking statements run in the Active
  region before the #0 process resumes; its nonblocking update waits for the NBA region,
  which comes after the Inactive region.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int a = 0;
  int late = 0;
  initial begin
    #0;
    check(a == 3, $sformatf("after #0, a = %0d; the blocking writes in the other process should be done", a));
    check(late == 0, $sformatf("after #0, late = %0d; the nonblocking update should not have happened yet", late));
    #1;
    check(late == 9, "the nonblocking update never happened");
    if (errors == 0) $display("PASS");
    $finish;
  end
  initial begin
    a = 1;
    a = a + 2;
    late <= 9;
  end
endmodule
