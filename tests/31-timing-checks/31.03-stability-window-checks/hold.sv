/*
:section: 31.3.2 $hold
:summary: $hold flags a violation when the data change falls within the limit after the
  reference edge.
:flags-icarus: -gspecify
*/
module chk(input clk, input d);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $hold(posedge clk, d, 5, n);
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
    #100 clk = 1;
    #3 d = 1;     // 3 after the edge: violation
    #7 clk = 0;
    #90 clk = 1;
    #5 d = 0;     // exactly 5 after: end point, no violation
    #5 clk = 0;
    #20;
    check(u.violations == 1, $sformatf("expected 1 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
