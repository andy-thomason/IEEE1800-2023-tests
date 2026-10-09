/*
:section: 11.6.2 Example of expression bit-length problem
:summary: Intermediate results are sized to the widest operand, including the assignment target,
  so carries can be kept.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [15:0] a = 16'hFFFF, b = 16'h0001, sum16, ans;
  logic [16:0] sum17;
  initial begin
    sum16 = a + b;
    check(sum16 == 0, "16-bit context loses the carry");
    sum17 = a + b;
    check(sum17 == 17'h10000, "17-bit context keeps the carry");
    ans = (a + b) >> 1;
    check(ans == 16'h0000, "carry lost in a 16-bit context");
    ans = (a + b + 0) >> 1;
    check(ans == 16'h8000, "adding an unsized 0 makes the context 32 bits");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
