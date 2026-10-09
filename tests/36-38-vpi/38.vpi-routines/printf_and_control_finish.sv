/*
:section: 38.4 vpi_control()
:summary: vpi_printf writes output, and vpi_control with vpiFinish ends simulation after the
  routine returns.
:vpi: printf_and_control_finish.c
:expect: from vpi: 42
  PASS
*/
module top;
  initial begin
    $t_say_and_finish;
    #1 $display("FAIL: simulation continued after vpi_control(vpiFinish)");
  end
endmodule
