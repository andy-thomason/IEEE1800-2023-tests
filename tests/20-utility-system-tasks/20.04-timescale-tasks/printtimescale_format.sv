/*
:section: 20.4.2 $printtimescale
:summary: $printtimescale reports a module's time unit and precision in the prescribed Time
  scale of text format.
:expect: Time scale of (top) is 1ns / 1ps
  Time scale of (top.child) is 10us / 100ns
  Time scale of ($root) is 1ps / 1ps
*/
module sub;
  timeunit 10us;
  timeprecision 100ns;
endmodule

module top;
  timeunit 1ns;
  timeprecision 1ps;
  sub child();
  initial begin
    $printtimescale;
    $printtimescale(child);
    $printtimescale($root);
    $finish;
  end
endmodule
