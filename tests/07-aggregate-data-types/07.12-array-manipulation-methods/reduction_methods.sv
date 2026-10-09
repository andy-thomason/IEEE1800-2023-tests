/*
:section: 7.12.3 Array reduction methods
:summary: Reduction methods sum, product, and, or and xor yield one value typed by the element
  or with expression.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  byte b [] = '{2, 3, 5, 4};
  logic [3:0] m [2][2] = '{'{4'd1, 4'd2}, '{4'd3, 4'd4}};
  bit flags [300];
  int y;
  initial begin
    check(b.sum() == 14 && b.product() == 120, "sum and product");
    check(b.and() == 0 && b.or() == 7 && b.xor() == 0, "and, or, xor");
    check(b.xor with (item + 1) == (3 ^ 4 ^ 6 ^ 5), "xor with an expression");
    y = m.sum with (item.sum with (int'(item)));
    check(y == 10, "nested sum over two dimensions");
    foreach (flags[i]) flags[i] = 1'b1;
    check($bits(flags.sum()) == 1, "sum of bits is not 1 bit wide");
    y = flags.sum with (int'(item));
    check(y == 300, $sformatf("sum with int'(item) = %0d, expected 300", y));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
