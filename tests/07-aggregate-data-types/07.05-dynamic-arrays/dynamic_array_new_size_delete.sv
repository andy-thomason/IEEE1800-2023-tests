/*
:section: 7.5 Dynamic arrays
:summary: Dynamic arrays start empty, new[] sets size with default elements, and delete()
  empties them.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] nibbles [];
  int counts [] = new [3];
  int grid [][2][3] = new [2];
  int ragged [2][];
  initial begin
    check(nibbles.size() == 0, "uninitialised dynamic array is not empty");
    nibbles = new [5];
    check(nibbles.size() == 5 && nibbles[4] === 4'bxxxx, "new[5] with default elements");
    check(counts.size() == 3 && counts[2] == 0, "new in a declaration");
    check(nibbles.size() == $size(nibbles, 1), "size() differs from $size");
    grid[1][1][2] = 6;
    check(grid.size() == 2 && grid[1][1][2] == 6, "dynamic array of fixed-size elements");
    ragged[0] = new [4];
    ragged[1] = new [1];
    check(ragged[0].size() == 4 && ragged[1].size() == 1, "fixed array of dynamic subarrays");
    counts = new [0];
    check(counts.size() == 0, "new[0] did not empty the array");
    nibbles.delete();
    check(nibbles.size() == 0, "delete did not empty the array");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
