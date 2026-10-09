/*
:section: 11.3.1 Operators with real operands
:summary: Relational, logical and inside operators applied to real values produce a one-bit
  result.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  real r1 = 2.5, r2 = -0.5;
  initial begin
    check((r1 > r2) === 1'b1 && $bits(r1 > r2) == 1, "relational on reals is one bit");
    check((r1 && r2) === 1'b1 && (r1 || 0.0) === 1'b1 && !0.0, "logical operators on reals");
    check(r1 inside {[2.0:3.0]}, "inside with a real range");
    check(r1 ** 2 == 6.25 && -r2 == 0.5 && (r1 != r2), "arithmetic and equality on reals");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
