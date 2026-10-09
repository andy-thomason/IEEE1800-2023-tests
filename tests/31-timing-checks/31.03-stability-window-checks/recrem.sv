/*
:section: 31.3.6 $recrem
:summary: $recrem merges recovery and removal checks, flagging events inside either window
  around the reference edge.
:flags-icarus: -gspecify
*/
module chk(input clk, input rst);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $recrem(negedge rst, posedge clk, 8, 6, n);
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
    #5 clk = 1;     // recovery violation
    #10 clk = 0;
    rst = 1;
    #85 clk = 1;
    #3 rst = 0;     // removal violation
    #20;
    check(u.violations == 2, $sformatf("expected 2 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
