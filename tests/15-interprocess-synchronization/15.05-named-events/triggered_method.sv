/*
:section: 15.5.3 Persistent trigger: triggered built-in method
:summary: The triggered method reports whether an event fired during this time step, avoiding
  races with wait.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  event done;
  int resumed = -1;
  initial begin
    fork
      -> done;
      begin #0 wait (done.triggered); resumed = $time; end
    join
    check(resumed == 0, "wait on .triggered after the trigger in the same time step blocked");
    check(done.triggered, "triggered is false in the trigger's time step");
    #1;
    check(!done.triggered, "triggered stayed true in the next time step");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
