/*
:section: 15.5.1 Triggering an event
:summary: The ->> operator schedules an event trigger without blocking, optionally after a
  delay.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  event e;
  int fired_at = -1;
  int seen_before = 0;
  always @e fired_at = $time;
  initial begin
    ->> #3 e;
    check($time == 0, "->> blocked");
    #2 seen_before = (fired_at < 0);
    #2;
    check(seen_before && fired_at == 3, $sformatf("->> #3 fired at %0d", fired_at));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
