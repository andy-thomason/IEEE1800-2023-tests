/*
:section: 28.4 and, nand, nor, or, xor, and xnor gates
:summary: Multi-input logic gates extend naturally, and input count does not change the
  propagation delay.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a = 1, b = 1, c = 1, d = 0;
  wire y_and, y_xor, y_and2;
  and #4 g1(y_and, a, b, c, d);
  xor g2(y_xor, a, b, c, d);
  and #4 g3(y_and2, a, b);
  initial begin
    #5;
    check(y_and === 1'b0 && y_xor === 1'b1, "four-input gates");
    d = 1;
    #3;
    check(y_and === 1'b0 && y_xor === 1'b0, "still delayed at 3");
    #2;
    check(y_and === 1'b1, "four-input gate delay is the same 4 units");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
