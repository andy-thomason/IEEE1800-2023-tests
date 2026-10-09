/*
:section: 31.9 Negative timing checks
:summary: $setuphold accepts a negative hold value, shifting the violation window relative to
  the reference edge.
:description: Some tools need an option to honour negative limits; the window here lies wholly
  before the edge.
:flags-icarus: -gspecify
*/
module chk(input clk, input d);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $setuphold(posedge clk, d, 10, -3, n);
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
    #95 d = 1;     // 5 before the edge: inside the window [-10, -3)
    #5 clk = 1;
    #10 clk = 0;
    #88 d = 0;     // 2 before the edge: after the window
    #2 clk = 1;
    #10;
    check(u.violations == 1, $sformatf("expected 1 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
