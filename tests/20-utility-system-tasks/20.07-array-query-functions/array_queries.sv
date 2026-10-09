/*
:section: 20.7 Array query functions
:summary: Array query functions report bounds, increment, size and dimension counts for fixed,
  dynamic and queue dimensions.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:4][0:1] m [2:6][3:1];
  int i;
  int dyn [];
  string str;
  real r;
  initial begin
    check($dimensions(m) == 4 && $unpacked_dimensions(m) == 2, "dimension counts");
    check($left(m, 1) == 2 && $right(m, 1) == 6 && $increment(m, 1) == -1 && $low(m, 1) == 2 && $high(m, 1) == 6, "dimension 1 [2:6]");
    check($increment(m, 2) == 1 && $low(m, 2) == 1 && $high(m, 2) == 3 && $size(m, 2) == 3, "dimension 2 [3:1]");
    check($left(m, 3) == 7 && $right(m, 3) == 4 && $size(m, 3) == 4, "dimension 3 [7:4]");
    check($left(m, 4) == 0 && $increment(m, 4) == -1, "dimension 4 [0:1]");
    check($left(i) == 31 && $right(i) == 0 && $dimensions(i) == 1, "int as [31:0]");
    check($left(dyn) == 0 && $right(dyn) == -1 && $size(dyn) == 0 && $increment(dyn) == -1, "empty dynamic array");
    check($dimensions(str) == 1 && $unpacked_dimensions(str) == 0 && $dimensions(r) == 0, "string and real");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
