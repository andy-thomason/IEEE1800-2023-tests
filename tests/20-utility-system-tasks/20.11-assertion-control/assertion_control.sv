/*
:section: 20.11 Assertion control system tasks
:summary: $assertoff, $asserton and $assertfailoff control whether assertions are checked and
  whether their failure actions run.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int fails = 0;
  logic ok = 0;
  task automatic check_ok(); a1: assert (ok) else fails++; endtask
  initial begin
    check_ok();
    check(fails == 1, "assertion did not fail while on");
    $assertoff;
    check_ok();
    check(fails == 1, "$assertoff did not stop the assertion");
    $asserton;
    check_ok();
    check(fails == 2, "$asserton did not re-enable the assertion");
    $assertfailoff;
    check_ok();
    check(fails == 2, "$assertfailoff did not suppress the fail action");
    $assertfailon;
    $assertcontrol(4);
    check_ok();
    check(fails == 2, "$assertcontrol(4) (Off)");
    $assertcontrol(3);
    check_ok();
    check(fails == 3, "$assertcontrol(3) (On)");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
