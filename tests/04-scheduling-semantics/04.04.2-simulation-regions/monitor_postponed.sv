/*
:section: 4.4.2.9 Postponed events region
:summary: $monitor output is produced in the Postponed region, showing only final values for
  each time step.
:description: $monitor reports the settled value of each time slot (y=5), after the $display in that
  slot. The relative order of $monitor and $strobe output in one Postponed region is not
  specified, so they are tested separately.
:expect: monitor y=0
  display y=4
  monitor y=5
  monitor y=6
*/
module top;
  int y = 0;
  initial begin
    $monitor("monitor y=%0d", y);
    #1;
    y = 4;
    $display("display y=%0d", y);
    y = 5;
    #1;
    y = 6;
    #1;
    $finish;
  end
endmodule
