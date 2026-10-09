/*
:section: 7.4.2 Unpacked arrays
:summary: An unpacked dimension [N] equals [0:N-1], and arrays of at least 16M elements are
  supported.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int by_size [6][3];
  int by_range [0:5][0:2];
  bit huge [16777216];
  initial begin
    check($left(by_size) == 0 && $right(by_size) == 5, "[6] is not [0:5]");
    check($left(by_size, 2) == 0 && $right(by_size, 2) == 2, "[3] is not [0:2]");
    by_size[5][2] = 9;
    by_range = by_size;
    check(by_range[5][2] == 9, "size and range forms are not the same array");
    huge[16777215] = 1'b1;
    huge[0] = 1'b1;
    check(huge[16777215] && huge[0] && !huge[8388608], "2^24-element array");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
