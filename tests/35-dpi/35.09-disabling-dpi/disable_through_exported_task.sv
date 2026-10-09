/*
:section: 35.9 Disabling DPI tasks and functions
:summary: Disabling a block during a mixed call chain makes the exported task report the disable
  to C.
:dpi: disable_through_exported_task.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  export "DPI-C" task sv_long_wait;
  import "DPI-C" context task c_runner();
  import "DPI-C" function int c_saw_disable();
  task sv_long_wait();
    #100;
  endtask
  bit after_call;
  initial begin
    fork
      begin : worker
        c_runner();
        after_call = 1;
      end
      #10 disable worker;
    join
    check(c_saw_disable() == 3, $sformatf("C saw export return 1 and disabled state set: code %0d", c_saw_disable()));
    check(!after_call, "the disabled block continued");
    check($time == 10, "the disable ended the call at time 10");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
