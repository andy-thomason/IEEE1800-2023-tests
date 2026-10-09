/*
:section: 11.6.1 Rules for expression bit lengths
:summary: Each operator produces a self-determined bit length such as the maximum operand width,
  one bit, or the left operand width.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] a4;
  logic [5:0] b6;
  logic [9:0] c10;
  initial begin
    check($bits(a4 + b6) == 6 && $bits(a4 & c10) == 10, "binary arithmetic and bitwise operators");
    check($bits(a4 == c10) == 1 && $bits(a4 < b6) == 1, "relational and equality operators");
    check($bits(a4 << c10) == 4 && $bits(b6 ** a4) == 6, "shift and power take the left operand's length");
    check($bits(1'b1 ? a4 : c10) == 10, "conditional operator");
    check($bits({a4, b6}) == 10 && $bits({3{a4, 1'b0}}) == 15, "concatenation and replication");
    check($bits(&c10) == 1 && $bits(!c10) == 1, "reduction and logical negation");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
