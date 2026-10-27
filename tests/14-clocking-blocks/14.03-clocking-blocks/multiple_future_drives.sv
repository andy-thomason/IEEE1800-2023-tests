/*
:section: 14.16.2 Driving clocking output signals
:summary: Several synchronous drives with different ## cycle delays each take effect in their
  own future cycle.
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
  logic [3:0] q = 0;
  default clocking cb @(posedge clk); output q; endclocking
  int seen [$];
  always @(posedge clk) #1 seen.push_back(q);
  initial begin
    @(cb);
    cb.q <= ##1 4'd1;
    cb.q <= ##2 4'd2;
    cb.q <= ##3 4'd3;
    ##4;
    check(seen.size() >= 4 && seen[1] == 1 && seen[2] == 2 && seen[3] == 3, $sformatf("values after each edge: %p", seen));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
