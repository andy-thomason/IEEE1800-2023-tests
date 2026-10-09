/*
:section: 22.5.2 `undef
:summary: `undef removes a single macro definition, and `undefineall removes every macro
  currently defined.
*/
`define A_MAC
`define B_MAC
`undef A_MAC
`undef NEVER_DEFINED
`ifdef A_MAC
  parameter int A_SEEN = 1;
`else
  parameter int A_SEEN = 0;
`endif
`undefineall
`ifdef B_MAC
  parameter int B_SEEN = 1;
`else
  parameter int B_SEEN = 0;
`endif
`define C_MAC
`ifdef C_MAC
  parameter int C_SEEN = 1;
`else
  parameter int C_SEEN = 0;
`endif

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  initial begin
    check(A_SEEN == 0, "`undef did not remove A_MAC");
    check(B_SEEN == 0, "`undefineall did not remove B_MAC");
    check(C_SEEN == 1, "a macro defined after `undefineall is missing");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
