/*
:section: 20.10 Severity system tasks
:summary: $info and $warning print formatted messages at run time and let the calling process
  continue.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int after = 0;
  initial begin
    $info("information %0d", 1);
    $warning("warning %s", "two");
    after = 1;
    check(after == 1, "$info or $warning stopped the process");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
