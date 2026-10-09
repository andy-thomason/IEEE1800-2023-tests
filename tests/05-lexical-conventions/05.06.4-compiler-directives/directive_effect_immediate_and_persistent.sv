/*
:section: 5.6.4 Compiler directives
:summary: A directive acts from the line where it is read and persists until another directive
  changes it.
*/
module first;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
`define STEP 3
  int a = `STEP;
`undef STEP
`ifdef STEP
  int b = 1;
`else
  int b = 0;
`endif
`define LATER 77
  initial begin
    check(a == 3, "macro was not available on the line after its definition");
    check(b == 0, "`undef did not take effect immediately");
  end
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  first u_first();
  int c = `LATER;
  initial begin
    #1;
    check(c == 77, "directive did not stay in effect for the rest of the compilation unit");
    check(u_first.errors == 0, "checks in module first failed");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
