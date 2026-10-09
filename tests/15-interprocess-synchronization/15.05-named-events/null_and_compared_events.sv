/*
:section: 15.5.5.2 Reclaiming events
:summary: Events may be set to null, compared, and tested as Boolean, and triggering null does
  nothing.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  event a, b, n;
  initial begin
    b = a;
    n = null;
    -> n;
    check(a == b && a === b && a != n && n == null, "event comparisons");
    check(a && !n, "Boolean test of events");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
