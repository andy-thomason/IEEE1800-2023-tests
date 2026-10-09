/*
:section: 20.4.1 Timescale retrieval system functions
:summary: $timeunit and $timeprecision return the exponent of a scope's time unit and precision,
  including $unit and $root.
*/
timeunit 10ns / 1ps;

module inner;
  timeunit 100us;
  timeprecision 10ns;
endmodule

module top;
  timeunit 1ms;
  timeprecision 1fs;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  inner u();
  initial begin
    check($timeunit == -3 && $timeprecision == -15, $sformatf("own scope %0d / %0d", $timeunit, $timeprecision));
    check($timeunit(u) == -4 && $timeprecision(u) == -8, $sformatf("other module %0d / %0d", $timeunit(u), $timeprecision(u)));
    check($timeunit($unit) == -8 && $timeprecision($unit) == -12, "compilation unit");
    check($timeunit($root) == -15 && $timeprecision($root) == -15, "$root is the global precision");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
