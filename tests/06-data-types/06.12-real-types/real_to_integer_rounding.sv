/*
:section: 6.12.1 Conversion
:summary: Real to integer conversion rounds to nearest, with exact halves rounded away from
  zero.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int i;
  real vals [6] = '{7.6, 7.5, 7.4, -2.5, 2.5, -0.4};
  int want [6] = '{8, 8, 7, -3, 3, 0};
  initial begin
    foreach (vals[k]) begin
      i = vals[k];
      check(i == want[k], $sformatf("%f converted to %0d, expected %0d", vals[k], i, want[k]));
    end
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
