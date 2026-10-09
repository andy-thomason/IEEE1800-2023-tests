/*
:section: 31.3.3 $setuphold
:summary: $setuphold reports both setup and hold violations around the reference edge using its
  two limits.
:flags-icarus: -gspecify
*/
module chk(input clk, input d);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $setuphold(posedge clk, d, 10, 5, n);
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
    #95 d = 1;    // 5 before the edge: setup violation
    #5 clk = 1;
    #10 clk = 0;
    #90 clk = 1;
    #4 d = 0;     // 4 after the edge: hold violation
    #6 clk = 0;
    #80 d = 1;    // exactly 10 before the edge: no violation
    #10 clk = 1;
    #5 d = 0;     // exactly 5 after the edge: no violation
    #10;
    check(u.violations == 2, $sformatf("expected 2 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
