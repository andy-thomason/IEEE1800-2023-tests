/*
:section: 14.16 Synchronous drives
:summary: Synchronous drives update outputs at the clocking event, after any declared output
  skew.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  timeunit 1ns; timeprecision 1ns;
  logic clk = 0;
  always #5 clk = ~clk;
  logic [7:0] q = 0;
  logic [7:0] late = 0;
  default clocking cb @(posedge clk);
    output q;
    output #2 late;
  endclocking
  initial begin
    @(cb);
    cb.q <= 8'd7;
    #0;
    check(q == 0, "a zero-skew drive changed the signal before the Re-NBA region");
    #1;
    check(q == 7, "zero-skew drive did not mature in the clocking event's time step");
    cb.late <= 8'd9;
    @(cb);
    check(late == 0, "output skew #2 drove early");
    #2;
    check(late == 0, "output skew #2: the value changed before the Re-NBA region of t=17");
    #1;
    check(late == 9, $sformatf("output skew #2 did not drive at t=17 (late = %0d at %0t)", late, $time));
    cb.q <= ##2 8'd11;
    ##1;
    check(q == 7, "a drive with ##2 matured after one cycle");
    ##1;
    #1;
    check(q == 11, "a drive with ##2 did not mature after two cycles");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
