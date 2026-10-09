/*
:section: 15.5.5.1 Merging events
:summary: Assigning one event to another merges them, affecting only waits that begin after the
  assignment.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  event e1, e2, e3;
  int hits = 0;
  bit stale_woke = 0;
  initial begin
    fork
      begin @e2 stale_woke = 1; end
      begin #1 e2 = e1; end
      begin #2 -> e2; end
      #5;
    join_any
    disable fork;
    check(!stale_woke, "a waiter blocked before the merge was woken");
    e3 = e1;
    fork
      begin @e3 hits++; end
      #1 -> e1;
    join
    check(hits == 1, "triggering one name did not wake a waiter on the merged name");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
