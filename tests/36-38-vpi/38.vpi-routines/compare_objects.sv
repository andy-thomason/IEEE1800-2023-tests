/*
:section: 38.3 vpi_compare_objects()
:summary: vpi_compare_objects yields 1 only when both handles denote one identical object, else
  0.
:vpi: compare_objects.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int x, y, same, different;
  initial begin
    $t_cmp(x, same, different);
    check(same == 1, "two handles to top.x compare equal");
    check(different == 0, "handles to top.x and top.y differ");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
