/*
:section: 30.4.4.1 Conditional expression
:summary: A state-dependent path delay is used only while its if condition evaluates true.
:flags-icarus: -gspecify
*/
module dut(input a, input sel, output y);
  buf b(y, a);
  specify
    if (sel) (a => y) = 2;
    if (!sel) (a => y) = 8;
  endspecify
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a = 0, sel = 1;
  wire y;
  dut u(.a(a), .sel(sel), .y(y));
  initial begin
    #20 a = 1;
    #3 check(y === 1'b1, "sel=1 picks delay 2");
    sel = 0;
    #17 a = 0;
    #7 check(y === 1'b1, "sel=0: not changed at 7");
    #2 check(y === 1'b0, "sel=0 picks delay 8");
    sel = 1'bx;
    #11 a = 1;
    #3 check(y === 1'b1, "x condition counts as true; the smaller active delay 2 is used");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
