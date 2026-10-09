/*
:section: 38.36 vpi_register_cb()
:summary: A cbAfterDelay callback fires after the requested delay, and vpi_get_time reports the
  current time.
:vpi: after_delay_callback_and_time.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int fired_at;
  initial begin
    #3;
    $t_later(fired_at);
    #10;
    check(fired_at == 10, $sformatf("cbAfterDelay 7 from time 3 fired at %0d", fired_at));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
