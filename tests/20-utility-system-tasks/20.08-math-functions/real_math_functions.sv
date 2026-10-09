/*
:section: 20.8.2 Real math functions
:summary: Real math functions such as $ln, $exp, $sqrt and $pow take real arguments and behave
  like C library equivalents.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function automatic bit near(real got, real want); return (got - want < 1.0e-6) && (want - got < 1.0e-6); endfunction
  initial begin
    check(near($ln(1.0), 0.0) && near($log10(1000.0), 3.0) && near($exp(0.0), 1.0), "logs and exp");
    check(near($sqrt(2.25), 1.5) && near($pow(2.0, 10.0), 1024.0), "sqrt and pow");
    check(near($floor(-1.5), -2.0) && near($ceil(-1.5), -1.0), "floor and ceil");
    check(near($sin(0.0), 0.0) && near($cos(0.0), 1.0) && near($atan2(1.0, 1.0), 0.7853981634), "trigonometry");
    check(near($hypot(3.0, 4.0), 5.0) && near($tanh(0.0), 0.0) && near($acosh(1.0), 0.0), "hypot and hyperbolic");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
