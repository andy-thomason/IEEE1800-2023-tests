/*
:section: 11.7 Signed expressions
:summary: $signed and $unsigned convert an expression's signedness, affecting comparisons and
  extension.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:0] u = 8'hF0;
  logic signed [7:0] s;
  logic [15:0] r;
  initial begin
    check($signed(u) < 0 && $unsigned(8'sh80) > 0, "$signed and $unsigned");
    r = $signed(u);
    check(r == 16'hFFF0, "$signed result is sign-extended");
    r = u;
    check(r == 16'h00F0, "unsigned value is zero-extended");
    s = 8'sd5;
    check(s * u > 0, "mixing signed and unsigned operands makes the expression unsigned");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
