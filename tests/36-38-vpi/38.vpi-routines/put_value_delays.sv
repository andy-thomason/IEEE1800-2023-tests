/*
:section: 38.34 vpi_put_value()
:summary: vpi_put_value supports immediate, inertial and transport delays, with inertial
  removing pending events.
:vpi: put_value_delays.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int now_v, inertial_v, transport_v;
  initial begin
    #10;
    $t_put(now_v, inertial_v, transport_v);
    check(now_v == 1, "vpiNoDelay applied immediately");
    #4 check(inertial_v == 0 && transport_v == 0, "delayed puts not applied at 4");
    #2 check(transport_v == 2, "transport put at 5");
    #3 check(inertial_v == 3, $sformatf("second inertial put at 8 replaced the first: %0d", inertial_v));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
