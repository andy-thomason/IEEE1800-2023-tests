/*
:section: 5.6.1 Escaped identifiers
:summary: An escaped identifier runs from the backslash to the next white space character.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int \a+b = 7;
  int a = 100, b = 1000;
  int r;
  initial begin
    r = \a+b + 1;
    check(r == 8, $sformatf("\\a+b + 1 = %0d, expected 8 (the identifier ends at the space)", r));
    r = a+b;
    check(r == 1100, $sformatf("a+b = %0d", r));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
