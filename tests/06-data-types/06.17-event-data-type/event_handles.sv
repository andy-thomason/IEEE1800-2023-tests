/*
:section: 6.17 Event data type
:summary: Assigning one event to another makes them aliases, while assigning null detaches the
  event.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  event ping;
  event alias_of_ping = ping;
  event other;
  event nothing = null;
  int woke = 0;
  initial begin
    @(ping) woke = 1;
  end
  initial begin
    check(ping != null && other != null, "events without an initialiser are null");
    check(nothing == null, "event initialised to null is not null");
    check(alias_of_ping == ping && other != ping, "event comparison");
    #1 -> alias_of_ping;
    #1 check(woke == 1, "triggering the alias did not wake a waiter on the original");
    alias_of_ping = null;
    check(alias_of_ping == null && ping != null, "assigning null broke the original");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
