/*
:section: 35.5.5 Function result
:summary: An imported function returning scalar logic can deliver 0, 1, z and x values to
  SystemVerilog.
:dpi: logic_result_four_state.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function logic r_logic(input int which);
  initial begin
    check(r_logic(0) === 1'b0 && r_logic(1) === 1'b1, "known logic results");
    check(r_logic(2) === 1'bz && r_logic(3) === 1'bx, "z and x logic results");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
