/*
:section: 14.10 Clocking block events
:summary: Naming a clocking block in an event control waits for that block's clocking event.
*/
module top;
  timeunit 1ns; timeprecision 1ns;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk = 0;
  always #5 clk = ~clk;
  logic [3:0] v = 0;
  int edges = 0;
  clocking cb @(negedge clk);
    input v;
  endclocking
  always @(cb) edges++;
  always @(posedge clk) v <= v + 1;
  initial begin
    #31;
    check(edges == 3, $sformatf("clocking block event fired %0d times on negedges by t=31", edges));
    @(cb);
    check(cb.v == v, "sampled value not updated before the clocking block event");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
