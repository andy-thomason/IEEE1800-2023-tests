/*
:section: 27.2 Overview
:summary: Parameters inside generate blocks act as localparams, and generate blocks may contain
  nested generates.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  for (genvar g = 0; g < 2; g++) begin : blk
    parameter int SCALE = 10 * (g + 1);
    int value = SCALE;
    if (g == 1) begin : inner
      int deeper = SCALE + 1;
    end
  end
  initial begin
    #1;
    check(blk[0].value == 10 && blk[1].value == 20, "per-instance parameter values");
    check(blk[1].inner.deeper == 21, "nested generate construct");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
