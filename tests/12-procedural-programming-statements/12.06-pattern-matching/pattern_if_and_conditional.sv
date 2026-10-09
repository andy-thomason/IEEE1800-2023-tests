/*
:section: 12.6.2 Pattern matching in if statements
:summary: if and ?: conditions may use matches with &&& clauses evaluated left to right, binding
  pattern variables.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef union tagged { void Nothing; int Some; } opt_t;
  opt_t o;
  int r;
  bit enable = 1;
  initial begin
    o = tagged Some 4;
    if (o matches tagged Some .x &&& enable &&& x > 3) r = x;
    else r = -1;
    check(r == 4, "if with matches and filters");
    o = tagged Nothing;
    r = (o matches tagged Some .y) ? y : 99;
    check(r == 99, "conditional expression with matches");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
