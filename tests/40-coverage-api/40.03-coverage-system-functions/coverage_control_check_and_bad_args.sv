/*
:section: 40.3.2.1 $coverage_control
:summary: $coverage_control with SV_COV_CHECK returns a status macro, and invalid arguments
  yield SV_COV_ERROR.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int chk, bad;
  initial begin
    chk = $coverage_control(`SV_COV_CHECK, `SV_COV_TOGGLE, `SV_COV_HIER, $root);
    check(chk == `SV_COV_OK || chk == `SV_COV_NOCOV || chk == `SV_COV_PARTIAL, $sformatf("check on $root returned %0d", chk));
    bad = $coverage_control(`SV_COV_START, `SV_COV_TOGGLE, `SV_COV_MODULE, "no_such_module_anywhere");
    check(bad == `SV_COV_ERROR, $sformatf("start on a nonexistent module returned %0d", bad));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
