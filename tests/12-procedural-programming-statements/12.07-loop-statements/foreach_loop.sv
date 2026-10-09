/*
:section: 12.7.3 The foreach-loop
:summary: foreach visits each array element, supporting multiple dimensions, strings, omitted
  indices and descending ranges.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int grid [2][3];
  logic [3:0][1:0] packed2;
  string word = "abc";
  int down [5:2];
  int visits, sum, first_index;
  initial begin
    visits = 0;
    foreach (grid[i, j]) visits++;
    check(visits == 6, "two loop variables");
    visits = 0;
    foreach (grid[, j]) visits++;
    check(visits == 3, "skipped first dimension");
    visits = 0;
    foreach (grid[i]) visits++;
    check(visits == 2, "only the first dimension");
    visits = 0;
    foreach (packed2[i, j]) visits++;
    check(visits == 8, "packed dimensions");
    sum = 0;
    foreach (word[k]) sum += word[k];
    check(sum == 97 + 98 + 99, "string as an array of bytes");
    first_index = -1;
    foreach (down[k]) if (first_index < 0) first_index = k;
    check(first_index == 5, "iteration starts at the left bound");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
