/*
:section: 35.8 Exported tasks
:summary: An exported task can be called from a context imported task and may advance simulation
  time.
:dpi: export_task_consumes_time.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  export "DPI-C" task sv_wait;
  import "DPI-C" context task c_wait_twice(input int n);
  task sv_wait(input int n);
    #(n);
  endtask
  initial begin
    c_wait_twice(5);
    check($time == 10, $sformatf("exported task delays from an imported task ended at %0t", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
