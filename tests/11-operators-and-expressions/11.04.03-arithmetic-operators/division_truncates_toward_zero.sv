/*
:section: 11.4.3 Arithmetic operators
:summary: Integer division discards any fractional remainder by rounding toward zero.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int p, n, q;
  initial begin
    p = 17;
    n = -17;
    q = p / 5;    check(q == 3, $sformatf("17 / 5 = %0d", q));
    q = n / 5;    check(q == -3, $sformatf("-17 / 5 = %0d, expected -3 (not -4)", q));
    q = p / -5;   check(q == -3, $sformatf("17 / -5 = %0d, expected -3 (not -4)", q));
    q = n / -5;   check(q == 3, $sformatf("-17 / -5 = %0d", q));
    q = 4 / p;    check(q == 0, $sformatf("4 / 17 = %0d", q));
    q = -4 / p;   check(q == 0, $sformatf("-4 / 17 = %0d", q));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
