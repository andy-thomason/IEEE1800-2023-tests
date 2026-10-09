/*
:section: 11.4.3 Arithmetic operators
:summary: The binary arithmetic operators +, -, *, /, % and ** compute their usual integer
  results.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int a, b;
  initial begin
    a = 23;
    b = 19;
    check(a + b == 42, $sformatf("23 + 19 = %0d", a + b));
    check(a - b == 4, $sformatf("23 - 19 = %0d", a - b));
    check(b - a == -4, $sformatf("19 - 23 = %0d", b - a));
    check(a * b == 437, $sformatf("23 * 19 = %0d", a * b));
    check(437 / b == 23, $sformatf("437 / 19 = %0d", 437 / b));
    check(a % b == 4, $sformatf("23 %% 19 = %0d", a % b));
    check(b ** 2 == 361, $sformatf("19 ** 2 = %0d", b ** 2));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
