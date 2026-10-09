/*
:section: 5.7.2 Real literal constants
:summary: Real literals may use fixed-point or exponent notation, and both forms have type real.
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
    real d = got - want;
    if (d < 0) d = -d;
    return d <= 1.0e-12 * (want < 0 ? -want : want) + 1.0e-300;
  endfunction
  initial begin
    check(near(3.75, 15.0 / 4.0), "3.75");
    check(near(7E3, 7000.0), "7E3");
    check(near(7e3, 7000.0), "7e3");
    check(near(2.5e-2, 0.025), "2.5e-2");
    check(near(6.5E+1, 65.0), "6.5E+1");
    check(near(42e0, 42.0), "42e0");
    check(near(1_234.5_6, 1234.56), "underscores in a real literal");
    // Only a real-typed literal keeps the fraction in these divisions.
    check(near(7.5 / 2, 3.75), "7.5 / 2 is not 3.75, so 7.5 was not real");
    check(near(1e0 / 4, 0.25), "1e0 / 4 is not 0.25, so 1e0 was not real");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
