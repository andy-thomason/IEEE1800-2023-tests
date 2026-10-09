/*
:section: 11.4.3 Arithmetic operators
:summary: Unary plus and minus bind more tightly than binary arithmetic operators.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int m, a;
  logic [3:0] u;
  initial begin
    m = 6;
    a = 5;
    check(+m == 6, $sformatf("+m = %0d", +m));
    check(-m == -6, $sformatf("-m = %0d", -m));
    check(-(-m) == 6, $sformatf("-(-m) = %0d", -(-m)));
    check(a - -m == 11, $sformatf("5 - -6 = %0d", a - -m));
    // (-6) ** 2 is 36; -(6 ** 2) would be -36.
    check(-m ** 2 == 36, $sformatf("-m ** 2 = %0d, expected 36", -m ** 2));
    // (-6) & 7 is 2; -(6 & 7) would be -6.
    check((-m & 7) == 2, $sformatf("-m & 7 = %0d, expected 2", -m & 7));
    u = 4'd3;
    u = -u;
    check(u == 4'd13, $sformatf("unary minus of 4'd3 in 4 bits = %0d", u));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
