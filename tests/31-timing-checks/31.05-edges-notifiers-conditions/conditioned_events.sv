/*
:section: 31.7 Enabling timing checks with conditioned events
:summary: A timing check event qualified with &&& is detected only while its condition is true.
:flags-icarus: -gspecify
*/
module chk(input clk, input d, input en);
  reg n;
  int violations;
  always @(n) if ($time > 0) violations++;
  reg n2;
  int violations2;
  always @(n2) if ($time > 0) violations2++;
  specify
    $setup(d, posedge clk &&& en, 10, n);
      $setup(d, posedge clk &&& (en == 1'b1), 10, n2);
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
  logic clk = 0, d = 0, en = 0;
  chk u(.clk(clk), .d(d), .en(en));
  initial begin
    #100 d = 1;
    #2 clk = 1;      // en = 0: neither check enabled
    #10 clk = 0;
    en = 1;
    #88 d = 0;
    #2 clk = 1;      // en = 1: both checks report
    #10 clk = 0;
    en = 1'bx;
    #88 d = 1;
    #2 clk = 1;      // en = x: only the == check reports
    #10;
      check(u.violations2 == 2, $sformatf("nondeterministic condition: expected 2, saw %0d", u.violations2));
    check(u.violations == 1, $sformatf("expected 1 violation(s), saw %0d", u.violations));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
