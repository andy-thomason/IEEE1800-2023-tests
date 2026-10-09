/*
:section: 31.4.4 $width
:summary: $width flags pulses shorter than the limit, but ignores glitches below the threshold
  argument.
:flags-icarus: -gspecify
*/
module chk(input clk, input g);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $width(posedge clk, 10, 0, n);
    $width(posedge g, 10, 3, n);
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
  logic clk = 0, g = 0;
  chk u(.clk(clk), .g(g));
  initial begin
    #100 clk = 1;
    #5 clk = 0;      // 5 wide: violation
    #20 clk = 1;
    #10 clk = 0;     // 10 wide: fine
    #20 g = 1;
    #2 g = 0;        // 2 wide: below the threshold, ignored
    #20 g = 1;
    #5 g = 0;        // 5 wide: violation
    #20;
    check(u.violations == 2, $sformatf("expected 2 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
