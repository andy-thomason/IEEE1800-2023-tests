/*
:section: 20.4.3 $timeformat
:summary: $timeformat sets the unit, precision, suffix and minimum width used when %t prints
  time values.
:expect: [   1.50 ns]
  [1500ps]
*/
module top;
  timeunit 1ps;
  timeprecision 1ps;
  initial begin
    #1500;
    $timeformat(-9, 2, " ns", 10);
    $display("[%t]", $realtime);
    $timeformat(-12, 0, "ps", 0);
    $display("[%t]", $time);
    $finish;
  end
endmodule
