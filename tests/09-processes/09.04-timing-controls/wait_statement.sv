/*
:section: 9.4.3 Level-sensitive event control
:summary: A wait statement blocks until its condition becomes true, then continues execution.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic ready = 0;
  initial #6 ready = 1;
  initial begin
    wait (ready);
    check($time == 6, "wait did not block until the condition was true");
    wait (ready);
    check($time == 6, "wait on a true condition blocked");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
