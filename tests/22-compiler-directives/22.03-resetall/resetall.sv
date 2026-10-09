/*
:section: 22.3 `resetall
:summary: `resetall returns directives like `default_nettype to defaults but leaves macro
  definitions in place.
*/
`define KEPT 5
`default_nettype none
`resetall

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  assign implicit_net = 1'b0;
  initial begin
    #1;
    check(implicit_net === 1'b0, "`resetall did not restore `default_nettype wire");
    check(`KEPT == 5, "`resetall removed a macro");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
