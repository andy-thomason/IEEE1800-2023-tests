/*
:section: 9.2.2.3 Latched logic always_latch procedure
:summary: always_latch behaves like always_comb but is intended for modeling level-sensitive
  latch logic.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic en = 0, d = 0, q;
  always_latch if (en) q <= d;
  initial begin
    d = 1;
    #1 check(q === 1'bx, "latch passed data while disabled");
    en = 1;
    #1 check(q === 1'b1, "latch did not pass data while enabled");
    en = 0; d = 0;
    #1 check(q === 1'b1, "latch did not hold");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
