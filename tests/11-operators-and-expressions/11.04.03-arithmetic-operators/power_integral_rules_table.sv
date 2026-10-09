/*
:section: 11.4.3 Arithmetic operators
:summary: Integral ** follows special cases for bases of -1, 0 and 1 and for negative exponents.
:description: Every cell of Table 11-4, using odd and even exponents of each sign.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  integer r;
  task automatic expect_pow(input integer base, input integer exponent, input integer want);
    r = base ** exponent;
    check(r === want, $sformatf("%0d ** %0d = %0d, expected %0d", base, exponent, r, want));
  endtask
  initial begin
    // op1 < -1
    expect_pow(-3, 3, -27);  expect_pow(-3, 2, 9);   expect_pow(-3, 0, 1);
    expect_pow(-3, -3, 0);   expect_pow(-3, -2, 0);
    // op1 == -1
    expect_pow(-1, 5, -1);   expect_pow(-1, 4, 1);   expect_pow(-1, 0, 1);
    expect_pow(-1, -5, -1);  expect_pow(-1, -4, 1);
    // op1 == 0
    expect_pow(0, 5, 0);     expect_pow(0, 4, 0);    expect_pow(0, 0, 1);
    expect_pow(0, -5, 'x);   expect_pow(0, -4, 'x);
    // op1 == 1
    expect_pow(1, 5, 1);     expect_pow(1, 4, 1);    expect_pow(1, 0, 1);
    expect_pow(1, -5, 1);    expect_pow(1, -4, 1);
    // op1 > 1
    expect_pow(3, 5, 243);   expect_pow(3, 4, 81);   expect_pow(3, 0, 1);
    expect_pow(3, -5, 0);    expect_pow(3, -4, 0);
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
