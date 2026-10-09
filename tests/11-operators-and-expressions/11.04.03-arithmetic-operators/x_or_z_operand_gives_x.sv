/*
:section: 11.4.3 Arithmetic operators
:summary: An arithmetic result becomes entirely x if any operand bit holds x or z.
:description: One x or z bit in either operand makes every result bit x, including where
  Table 11-4 would otherwise give a fixed result.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:0] xv, zv, two, one, zero, r;
  task automatic expect_x(input logic [7:0] got, input string what);
    check(got === 8'hxx, $sformatf("%s = %b, expected all x", what, got));
  endtask
  initial begin
    xv = 8'b0000_x011;
    zv = 8'b0z00_0110;
    two = 8'd2;
    one = 8'd1;
    zero = 8'd0;
    r = xv + two;  expect_x(r, "x + 2");
    r = two + zv;  expect_x(r, "2 + z");
    r = xv - two;  expect_x(r, "x - 2");
    r = two - zv;  expect_x(r, "2 - z");
    r = xv * two;  expect_x(r, "x * 2");
    r = zero * zv; expect_x(r, "0 * z");
    r = xv / two;  expect_x(r, "x / 2");
    r = two / zv;  expect_x(r, "2 / z");
    r = zv % two;  expect_x(r, "z % 2");
    r = two % xv;  expect_x(r, "2 % x");
    r = xv ** two; expect_x(r, "x ** 2");
    r = two ** zv; expect_x(r, "2 ** z");
    r = one ** xv; expect_x(r, "1 ** x");
    r = zv ** zero; expect_x(r, "z ** 0");
    r = -xv;       expect_x(r, "-x");
    r = -zv;       expect_x(r, "-z");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
