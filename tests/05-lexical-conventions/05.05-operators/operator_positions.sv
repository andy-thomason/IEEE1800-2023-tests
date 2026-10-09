/*
:section: 5.5 Operators
:summary: Unary operators precede their operand, binary operators sit between operands, and ?:
  takes three operands.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int a = 6, b = 4;
  bit c = 1;
  initial begin
    check(-a == -6, "unary minus");
    check(~a == -7, "unary bitwise not");
    check(!c == 0, "unary logical not");
    check(&4'b1111 == 1, "unary reduction and");
    check(a - b == 2, "binary minus");
    check(a << 1 == 12, "binary shift");
    check((c ? a : b) == 6, "conditional, true");
    check((!c ? a : b) == 4, "conditional, false");
    check((c ? (a > b ? 1 : 2) : 3) == 1, "nested conditional");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
