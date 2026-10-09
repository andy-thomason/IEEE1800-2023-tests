/*
:section: 20.2 Simulation control system tasks
:summary: $finish ends simulation immediately, and final procedures then run once at the end.
*/
module top;
  int late = 0;
  initial #5 $finish(1);
  initial #10 late = 1;
  final begin
    if (late) $display("FAIL: a process ran after $finish");
    else if ($time != 5) $display("FAIL: finished at %0t", $time);
    else $display("PASS");
  end
endmodule
