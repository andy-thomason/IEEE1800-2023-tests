/*
:section: 31.4.6 $nochange
:summary: $nochange reports a violation if data changes while the reference signal is at its
  active level.
:flags-icarus: -gspecify
*/
module chk(input clk, input d);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;

  specify
    $nochange(posedge clk, d, 0, 0, n);
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
    #10 d = 1;       // while clk is high: violation
    #10 clk = 0;
    #10 d = 0;       // while low: fine
    #10 clk = 1;
    d = 1;           // simultaneous with the leading edge: fine
    #10;
    check(u.violations == 1, $sformatf("expected 1 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
