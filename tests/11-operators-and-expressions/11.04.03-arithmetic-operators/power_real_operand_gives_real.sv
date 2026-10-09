/*
:section: 11.4.3 Arithmetic operators
:summary: When either operand of ** is real, the result is real-valued.
:description: Only defined cases are used; a zero base with a negative exponent, and a
  negative base with a non-integral exponent, are unspecified.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function automatic bit near(real got, real want);
    return (got - want) < 1.0e-9 && (want - got) < 1.0e-9;
  endfunction
  int four, eighty_one;
  real r, neg;
  initial begin
    four = 4;
    eighty_one = 81;
    neg = -2.0;
    r = four ** -1.0;        check(near(r, 0.25), $sformatf("int 4 ** -1.0 = %f, expected 0.25", r));
    r = 2.5 ** 2;            check(near(r, 6.25), $sformatf("2.5 ** 2 = %f", r));
    r = eighty_one ** 0.25;  check(near(r, 3.0), $sformatf("int 81 ** 0.25 = %f", r));
    r = neg ** 3.0;          check(near(r, -8.0), $sformatf("-2.0 ** 3.0 = %f", r));
    check(near(four ** -2.0, 0.0625), "int 4 ** -2.0 was not evaluated as real");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
