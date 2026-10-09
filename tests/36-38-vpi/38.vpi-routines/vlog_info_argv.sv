/*
:section: 38.22 vpi_get_vlog_info()
:summary: vpi_get_vlog_info reports invocation arguments, including plusargs, and product
  version strings.
:vpi: vlog_info_argv.c
:plusargs: +vpi_marker
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int ok, saw_plusarg, has_product;
  initial begin
    $t_info(ok, saw_plusarg, has_product);
    check(ok == 1, "vpi_get_vlog_info returned 1");
    check(saw_plusarg == 1, "argv contains the +vpi_marker plusarg");
    check(has_product == 1, "product string present");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
