/*
:section: 31.4.5 $period
:summary: $period flags a violation when consecutive same-direction reference edges are closer
  than the limit.
:flags-icarus: -gspecify
*/
module chk(input clk);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $period(posedge clk, 20, n);
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
  logic clk = 0;
  chk u(.clk(clk));
  initial begin
    #100 clk = 1;
    #10 clk = 0;
    #10 clk = 1;     // period 20: fine
    #5 clk = 0;
    #10 clk = 1;     // period 15: violation
    #10;
    check(u.violations == 1, $sformatf("expected 1 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
