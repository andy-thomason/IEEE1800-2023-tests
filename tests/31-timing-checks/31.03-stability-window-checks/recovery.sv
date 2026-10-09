/*
:section: 31.3.5 $recovery
:summary: $recovery flags a violation when the clock edge arrives within the limit after the
  reset release.
:flags-icarus: -gspecify
*/
module chk(input clk, input rst);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $recovery(negedge rst, posedge clk, 8, n);
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
  logic clk = 0, rst = 1;
  chk u(.clk(clk), .rst(rst));
  initial begin
    #100 rst = 0;
    #5 clk = 1;     // 5 after release: violation
    #10 clk = 0;
    rst = 1;
    #75 rst = 0;
    #8 clk = 1;     // exactly 8 after release: no violation
    #10;
    check(u.violations == 1, $sformatf("expected 1 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
