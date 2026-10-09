/*
:section: 11.3.3 Using integer literals in expressions
:summary: Unsized decimal integers are signed, while based literals without s are unsigned when
  negated.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  integer i;
  initial begin
    i = -12 / 3;
    check(i == -4, "-12 / 3");
    i = -'d12 / 3;
    check(i == 32'd1431655761, $sformatf("-'d12 / 3 = %0d", i));
    i = -'sd12 / 3;
    check(i == -4, "-'sd12 / 3");
    i = -4'sd12 / 3;
    check(i == 1, $sformatf("-4'sd12 / 3 = %0d", i));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
