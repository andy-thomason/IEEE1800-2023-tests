/*
:section: 6.24.1 Cast operator
:summary: A static cast produces the same value as assigning the operand to a variable of that
  type.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef logic [5:0] six_t;
  int i;
  shortint s;
  six_t six;
  initial begin
    check(int'(4.5 * 3.0) == 14, "int'(13.5) does not round like an assignment");
    check(shortint'({8'h81, 8'h02}) == -32510, "shortint'() of a 16-bit concatenation");
    six = 10'h3C5;
    check(six_t'(10'h3C5) == six, "cast and assignment to a typedef differ");
    check(real'(7) / 2 == 3.5, "real'(7)");
    s = -2;
    check(byte'(s) == -2, "byte'() of a shortint");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
