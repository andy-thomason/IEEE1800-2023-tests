/*
:section: 40.3.2.4 $coverage_merge
:summary: Merging a coverage database name that does not exist returns SV_COV_ERROR.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int r;
  initial begin
    r = $coverage_merge(`SV_COV_TOGGLE, "test1800_no_such_coverage_database");
    check(r == `SV_COV_ERROR, $sformatf("merge of a missing database returned %0d", r));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
