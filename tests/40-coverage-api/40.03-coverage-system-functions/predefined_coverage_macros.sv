/*
:section: 40.3.1 Predefined coverage constants in SystemVerilog
:summary: The predefined coverage macros such as SV_COV_START and SV_COV_HIER have their
  specified integer values.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask

  initial begin
    check(`SV_COV_START == 0 && `SV_COV_STOP == 1 && `SV_COV_RESET == 2 && `SV_COV_CHECK == 3, "control macros");
    check(`SV_COV_MODULE == 10 && `SV_COV_HIER == 11, "scope macros");
    check(`SV_COV_ASSERTION == 20 && `SV_COV_FSM_STATE == 21 && `SV_COV_STATEMENT == 22 && `SV_COV_TOGGLE == 23, "type macros");
    check(`SV_COV_OVERFLOW == -2 && `SV_COV_ERROR == -1 && `SV_COV_NOCOV == 0 && `SV_COV_OK == 1 && `SV_COV_PARTIAL == 2, "status macros");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
