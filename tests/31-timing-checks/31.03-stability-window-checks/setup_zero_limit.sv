/*
:section: 31.3.1 $setup
:summary: A $setup check with a zero limit never reports a violation.
:flags-icarus: -gspecify
*/
module chk(input clk, input d);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $setup(d, posedge clk, 0, n);
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
    #100 d = 1;
    clk = 1;
    #10 clk = 0;
    #10 d = 0;
    #0 clk = 1;
    #10;
    check(u.violations == 0, $sformatf("expected 0 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
