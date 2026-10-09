/*
:section: 7.11 Array querying functions
:summary: Array query functions such as $left, $size and $dimensions report array shape
  information.
:description: $increment is 1 when $left >= $right and -1 otherwise (20.7).
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:2][0:3] pk [10:12][4];
  int dyn [] = new [5];
  int q [$] = {1, 2, 3};
  initial begin
    check($dimensions(pk) == 4 && $unpacked_dimensions(pk) == 2, "dimension counts");
    check($left(pk) == 10 && $right(pk) == 12 && $increment(pk) == -1, "first unpacked dimension");
    check($left(pk, 2) == 0 && $right(pk, 2) == 3 && $size(pk, 2) == 4, "[4] dimension");
    check($left(pk, 3) == 7 && $low(pk, 3) == 2 && $high(pk, 3) == 7 && $increment(pk, 3) == 1, "first packed dimension");
    check($size(pk, 4) == 4 && $increment(pk, 4) == -1, "last packed dimension");
    check($size(dyn) == 5 && $right(dyn) == 4 && $left(dyn) == 0, "dynamic array");
    check($size(q) == 3 && $high(q) == 2, "queue");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
