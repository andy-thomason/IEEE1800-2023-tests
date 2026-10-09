/*
:section: 21.2.3 Continuous monitoring
:summary: $strobe prints once a time step finishes, and $monitor reprints on argument changes
  until $monitoroff.
:description: A new $monitor replaces the old list; $monitoron prints the current values
  immediately.
:expect: mon a=0
  mon a=1
  mon b=0
  mon b=5
  mon b=6
  mon b=7
*/
module top;
  int a = 0, b = 0;
  initial begin
    $monitor("mon a=%0d", a);
    #1 a = 1;
    #1 $monitor("mon b=%0d", b);
    #1 a = 2;
    #1 b = 5;
    #1 $monitoroff;
    #1 b = 6;
    #1 $monitoron;
    #1 b = 7;
    #1 $finish;
  end
endmodule
