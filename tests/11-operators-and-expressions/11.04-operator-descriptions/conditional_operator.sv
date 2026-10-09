/*
:section: 11.4.11 Conditional operator
:summary: An unknown condition makes ?: evaluate both branches and merge them bitwise, with
  differing bits becoming x.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic sel;
  logic [3:0] r;
  real rr;
  initial begin
    sel = 1'bx;
    r = sel ? 4'b1100 : 4'b1010;
    check(r === 4'b1xx0, $sformatf("x condition combined bit by bit: %b", r));
    r = sel ? 4'b10z1 : 4'b10z1;
    check(r === 4'b10x1, $sformatf("z in both operands gives x: %b", r));
    rr = sel ? 1.5 : 2.5;
    check(rr == 0.0, "x condition with real operands gives 0");
    sel = 1'bz;
    r = sel ? 4'b0110 : 4'b0110;
    check(r === 4'b0110, "z condition with equal operands");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
