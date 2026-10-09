/*
:section: 31.3.1 $setup
:summary: $setup flags a violation when data changes within the limit before the clock edge.
:flags-icarus: -gspecify
*/
module chk(input clk, input d);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $setup(d, posedge clk, 10, n);
  endspecify
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk = 0, d = 0;
  chk u(.clk(clk), .d(d));
  initial begin
    #100 d = 1;   // 5 before the edge: violation
    #5 clk = 1;
    #10 clk = 0;
    #85 d = 0;    // exactly 10 before the edge: window end point, no violation
    #10 clk = 1;
    #10 clk = 0;
    #80 d = 1;    // 15 before the edge: no violation
    #15 clk = 1;
    #10;
    check(u.violations == 1, $sformatf("expected 1 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
