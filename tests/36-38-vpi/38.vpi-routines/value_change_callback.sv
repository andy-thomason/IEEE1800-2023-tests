/*
:section: 38.36 vpi_register_cb()
:summary: A cbValueChange callback runs only when the watched object actually changes value.
:vpi: value_change_callback.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int watched, count;
  initial begin
    $t_watch(watched);
    #1 watched = 1;
    #1 watched = 2;
    #1 watched = 2;
    #1 watched = 5;
    #1 count = $t_changes();
    check(count == 3, $sformatf("value change callback fired %0d times", count));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
