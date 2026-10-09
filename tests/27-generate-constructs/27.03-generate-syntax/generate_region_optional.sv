/*
:section: 27.3 Generate construct syntax
:summary: Wrapping generate constructs in generate/endgenerate is optional and does not change
  meaning.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  generate
    for (genvar g = 0; g < 3; g++) begin : with_region
      int v = g;
    end
  endgenerate
  for (genvar g = 0; g < 3; g++) begin : without_region
    int v = g;
  end
  initial begin
    #1;
    check(with_region[2].v == 2 && without_region[2].v == 2, "both forms create the same blocks");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
