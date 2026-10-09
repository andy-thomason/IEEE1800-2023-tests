/*
:section: 31.3.4 $removal
:summary: $removal flags a violation when the reset release occurs within the limit before the
  clock edge.
:flags-icarus: -gspecify
*/
module chk(input clk, input rst);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $removal(negedge rst, posedge clk, 6, n);
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
    #100 clk = 1;
    #3 rst = 0;     // released 3 after the edge: violation
    #7 clk = 0;
    rst = 1;
    #90 clk = 1;
    #6 rst = 0;     // released exactly 6 after: no violation
    #10;
    check(u.violations == 1, $sformatf("expected 1 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
