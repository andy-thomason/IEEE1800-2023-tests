/*
:section: 22.5.1 `define
:summary: A macro may share a name with an ordinary identifier, and redefining a macro uses the
  most recent definition.
*/
`define width 8
`define LEVEL 1
`define LEVEL 2

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int width = 99;
  initial begin
    check(width == 99 && `width == 8, "macro and identifier with the same name");
    check(`LEVEL == 2, "the latest definition prevails");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
