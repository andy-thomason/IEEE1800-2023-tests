/*
:section: 20.3 Simulation time system functions
:summary: $time rounds to the module time unit, while $realtime returns a real value and $stime
  a 32-bit result.
*/
module top;
  timeunit 1ns; timeprecision 1ps;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function automatic bit near(real got, real want); return (got - want < 1.0e-9) && (want - got < 1.0e-9); endfunction
  initial begin
    #1.6;
    check($time == 2, $sformatf("$time = %0t, expected 2 (rounded)", $time));
    check($stime == 2 && $bits($stime) == 32, "$stime");
    check(near($realtime, 1.6), $sformatf("$realtime = %f", $realtime));
    check($bits($time) == 64, "$time is 64 bits");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
