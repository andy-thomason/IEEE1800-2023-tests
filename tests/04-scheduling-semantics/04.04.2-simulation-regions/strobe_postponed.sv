/*
:section: 4.4.2.9 Postponed events region
:summary: $strobe prints values at the end of the time step, after all assignments including
  nonblocking ones.
:description: $strobe prints the settled value for its time slot, after the nonblocking update, so
  it never shows x=1 and appears after the $display.
:expect: display x=2
  strobe x=3
*/
module top;
  int x = 0;
  initial begin
    #1;
    x = 1;
    $strobe("strobe x=%0d", x);
    x = 2;
    $display("display x=%0d", x);
    x <= 3;
    #1;
    $finish;
  end
endmodule
