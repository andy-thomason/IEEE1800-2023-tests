/*
:section: 7.7 Arrays as arguments to subroutines
:summary: Arrays passed by value are copied, and fixed, dynamic and queue arrays may be
  arguments.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function automatic int corner_sum(int m [3:1][3:1]);
    int r = m[3][3] + m[1][1];
    m[1][1] = -1;
    return r;
  endfunction
  function automatic int count_chars(string names []);
    int n = 0;
    foreach (names[i]) n += names[i].len();
    return n;
  endfunction
  function automatic int total4(int v [4:1]);
    return v[4] + v[3] + v[2] + v[1];
  endfunction
  int same [3:1][3:1];
  int shifted [1:3][0:2];
  string fixed_names [3] = '{"ab", "cde", "f"};
  string queued [$] = '{"wxyz"};
  int dyn [] = '{1, 2, 3, 4};
  int counts [int];
  function automatic int map_size(int m [int]);
    m[100] = 1;
    return m.size();
  endfunction
  initial begin
    foreach (same[i, j]) same[i][j] = i * 10 + j;
    foreach (shifted[i, j]) shifted[i][j] = i;
    check(corner_sum(same) == 44 && same[1][1] == 11, "fixed array passed by value");
    check(corner_sum(shifted) == 4, "array with different ranges but the same sizes");
    check(count_chars(fixed_names) == 6 && count_chars(queued) == 4, "fixed array and queue to a dynamic formal");
    check(total4(dyn) == 10, "dynamic array to a fixed formal of equal size");
    counts[1] = 1;
    check(map_size(counts) == 2 && counts.size() == 1, "associative array passed by value is copied");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
