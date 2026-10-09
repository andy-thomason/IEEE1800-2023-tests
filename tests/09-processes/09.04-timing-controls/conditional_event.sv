/*
:section: 9.4.2.3 Conditional event controls
:summary: An event control with iff only triggers when its qualifying condition is true.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk = 0, en = 0;
  int counted = 0;
  always @(posedge clk iff en) counted++;
  always #1 clk = ~clk;
  initial begin
    #4 en = 1;
    #4;
    check(counted == 2, $sformatf("counted %0d qualified edges", counted));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
