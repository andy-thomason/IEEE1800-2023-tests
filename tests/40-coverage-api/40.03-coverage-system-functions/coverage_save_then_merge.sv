/*
:section: 40.3.2.5 $coverage_save
:summary: $coverage_save stores coverage under a name for later $coverage_merge without altering
  current coverage.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] toggler = 0;
  int saved, merged, before, after;
  initial begin
    repeat (3) #1 toggler = toggler + 5;
    before = $coverage_get(`SV_COV_TOGGLE, `SV_COV_HIER, $root);
    saved = $coverage_save(`SV_COV_TOGGLE, "test1800_saved");
    after = $coverage_get(`SV_COV_TOGGLE, `SV_COV_HIER, $root);
    check(before == after, "saving changed the coverage state");
    if (saved == `SV_COV_OK) begin
      merged = $coverage_merge(`SV_COV_TOGGLE, "test1800_saved");
      check(merged == `SV_COV_OK || merged == `SV_COV_NOCOV, $sformatf("merge of the saved name returned %0d", merged));
    end else
      check(saved == `SV_COV_NOCOV, $sformatf("save returned %0d", saved));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
