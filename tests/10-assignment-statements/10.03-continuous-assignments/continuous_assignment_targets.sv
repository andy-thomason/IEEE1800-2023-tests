/*
:section: 10.3.2 The continuous assignment statement
:summary: A continuous assignment can drive explicitly declared nets, implicitly declared nets
  and variables, updating when operands change.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] a = 4'd1, b = 4'd2;
  wire [4:0] net_sum;
  logic [4:0] var_sum;
  wire [3:0] decl = a ^ b;
  assign net_sum = a + b;
  assign var_sum = a + b;
  assign {hi_bit, lo_bit} = a[1:0];
  initial begin
    #1 check(net_sum == 3 && var_sum == 3 && decl == 3, "initial evaluation");
    a = 4'd9;
    #1 check(net_sum == 11 && var_sum == 11 && decl == 4'b1011, "update on a right-hand side change");
    check(hi_bit === 1'b0 && lo_bit === 1'b1, "implicit nets in a concatenation target");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
