/*
:section: 39.5.2 Assertion control
:summary: vpiAssertionDisable stops new attempts of an assertion until vpiAssertionEnable
  re-enables it.
:vpi: disable_assertion_by_handle.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic clk = 0, v = 0;
  int fail_actions;
  a_check: assert property (@(posedge clk) v) else fail_actions++;
  initial begin
    $t_assertion_control(0);
    repeat (3) begin #5 clk = 1; #5 clk = 0; end
    check(fail_actions == 0, $sformatf("disabled assertion ran its fail action %0d times", fail_actions));
    $t_assertion_control(1);
    repeat (2) begin #5 clk = 1; #5 clk = 0; end
    check(fail_actions == 2, $sformatf("re-enabled assertion failed %0d times", fail_actions));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
