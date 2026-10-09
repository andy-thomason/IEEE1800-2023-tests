/*
:section: 11.4.12 Concatenation operators
:summary: Bits of a concatenation may be selected as though it were a packed vector indexed from
  zero.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] a = 4'hA, b = 4'h5;
  logic [7:0] sum;
  initial begin
    check({a, b}[6:3] == 4'b0100, "part-select of a concatenation");
    check({a, b}[7] == 1'b1, "bit-select of a concatenation");
    sum = 8'd200;
    check({sum + 8'd100}[7:0] == 8'd44, "select from a concatenation of one expression");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
