/*
:section: 9.6.2 Disable statement
:summary: disable on a named block or task terminates its active executions and resumes after
  it.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int steps = 0, task_steps = 0;
  task automatic slow();
    #2 task_steps++;
    #10 task_steps++;
  endtask
  initial begin
    begin : body
      steps++;
      #1;
      disable body;
      steps++;
    end
    check(steps == 1, "the rest of the disabled block ran");
    fork
      slow();
      slow();
      #5 disable slow;
    join
    check(task_steps == 2 && $time == 6, $sformatf("disable task: %0d steps at %0t", task_steps, $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
