/*
:section: 11.4.8 Bitwise operators
:summary: Binary bitwise operators zero-extend the narrower operand and yield unsigned results
  unless both operands are signed.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic signed [3:0] s4 = 4'sb1010;
  logic signed [7:0] s8 = 8'sb0000_1111;
  logic [7:0] u8 = 8'b0000_1111;
  initial begin
    check((s8 | s4) == 8'sb1111_1111, "signed operands: sign extension");
    check((u8 | s4) == 8'b0000_1111, "unsigned operand: zero extension");
    check((s8 & s4) < 0 == 0 && (s8 | s4) < 0, "signed result");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
