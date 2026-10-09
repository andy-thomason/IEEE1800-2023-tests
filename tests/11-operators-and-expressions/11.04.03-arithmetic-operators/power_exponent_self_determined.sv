/*
:section: 11.4.3 Arithmetic operators
:summary: The exponent operand of ** is sized and typed independently of the surrounding
  expression.
:description: The exponent's width and signedness must not affect, or be affected by,
  the rest of the expression. The result takes its type from the first operand.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int neg_two;
  logic [3:0] e_unsigned, base4;
  logic [7:0] e8, r8;
  logic signed [1:0] e_minus_one;
  initial begin
    // An unsigned exponent must not make a signed expression unsigned.
    neg_two = -2;
    e_unsigned = 4'd3;
    check((neg_two ** e_unsigned) < 0, "int -2 ** 4'd3 was treated as unsigned");
    check((neg_two ** e_unsigned) == -8, $sformatf("int -2 ** 4'd3 = %0d", neg_two ** e_unsigned));
    // The result width comes from the base, not the exponent.
    base4 = 4'd2;
    e8 = 8'd5;
    check($bits(base4 ** e8) == 4, $sformatf("$bits(4-bit ** 8-bit) = %0d", $bits(base4 ** e8)));
    // A signed exponent keeps its sign inside an unsigned expression, so it is -1, not 3.
    e_minus_one = -2'sd1;
    r8 = 8'd2 ** e_minus_one;
    check(r8 == 8'd0, $sformatf("8'd2 ** (2-bit signed -1) = %0d, expected 0 (2 ** 3 would be 8)", r8));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
