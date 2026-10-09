/*
:section: 11.3.6 Assignment within an expression
:summary: A parenthesized blocking assignment without timing control can appear inside an
  expression and yields the assigned value.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int a, b, c;
  byte tiny;
  initial begin
    a = (b = 5) + 1;
    check(a == 6 && b == 5, "assignment as an operand");
    if ((c = a * 2) > 10) check(c == 12, "assignment in a condition");
    a = (tiny = 300);
    check(tiny == 44 && a == 44, "the returned value has the left-hand data type");
    a = (b += 3);
    check(a == 8 && b == 8, "compound assignment in an expression");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
