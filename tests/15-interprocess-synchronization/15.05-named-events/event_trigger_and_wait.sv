/*
:section: 15.5.2 Waiting for an event
:summary: Triggering an event with -> releases every process currently waiting on it with @.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  event go;
  int woken = 0;
  initial begin
    fork
      begin @go woken++; end
      begin @go woken++; end
      #1 -> go;
    join
    check(woken == 2, "a trigger did not unblock all waiters");
    fork
      -> go;
      begin #0 @go woken = 99; end
      #5;
    join_any
    check(woken == 2, "a wait that started after the trigger was unblocked");
    disable fork;
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
