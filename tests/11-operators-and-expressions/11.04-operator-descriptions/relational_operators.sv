/*
:section: 11.4.4 Relational operators
:summary: Relational comparisons return 1'b1 or 1'b0, give x for unknown bits, and compare
  signed only if every operand is signed.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] u4 = 4'b1111;
  logic signed [3:0] s4 = -1;
  logic signed [7:0] s8 = -2;
  initial begin
    check((3 < 5) === 1'b1 && (5 <= 4) === 1'b0, "true and false results");
    check((4'b1x00 > 4'b0001) === 1'bx, "x operand gives x");
    check((u4 > s4) === 1'b0 && (u4 == s4) == 1, "mixed signedness compares unsigned");
    check(s8 < s4, "both signed: -2 < -1");
    check(s4 < 8'sd5, "signed sign-extension to the larger width");
    check(2 < 2.5 && !(3 < 2.5), "integer compared with a real");
    check(1 + 2 < 4 - 0 === 1'b1, "arithmetic binds tighter than relational");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
