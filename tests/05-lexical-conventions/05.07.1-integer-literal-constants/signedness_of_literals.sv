/*
:section: 5.7.1 Integer literal constants
:summary: Plain decimals and s-based literals are signed, other based literals unsigned; s
  leaves bits unchanged.
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
    check(-3 < 0, "simple decimal is signed");
    check(4'sb1011 < 0, "4'sb1011 is not negative");
    check(!(4'b1011 < 0), "4'b1011 is negative");
    check(4'sb1011 === 4'b1011, "s changed the bit pattern");
    check(8'sd200 === 8'd200, "s changed the bit pattern of a decimal");
    check(('hFFFF_FFFF + 1) == 0 || ('hFFFF_FFFF > 0), "'h literal treated as signed");
    check('sh8000_0000 < 0, "'sh literal with top bit set is not negative");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
