/*
:section: 11.3.2 Operator precedence
:summary: Operators follow the defined precedence table and associate left to right except
  conditional and implication.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int a = 2, b = 3, c = 4;
  bit p = 1, q = 0, r = 1;
  initial begin
    check(a + b * c == 14, "* before +");
    check(a ** 2 ** 2 == 16, "** associates left to right");
    check(a - b - c == -5, "- associates left to right");
    check((a << 1 + 1) == 8, "+ before <<");
    check((a < b == 1) == 1, "< before ==");
    check((1 | 2 & 0) == 1, "& before |");
    check((p || q && 0) == 1, "&& before ||");
    check((p ? q : r ? 1 : 0) == 0, "?: associates right to left");
    check((q -> p -> q) == 1, "-> associates right to left");
    check(-a ** 2 == 4, "unary minus binds tighter than **");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
