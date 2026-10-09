/*
:section: 12.7.3 The foreach-loop
:summary: foreach over a multidimensional array iterates every combination of the listed index
  variables.
*/
module top;
  int grid [3][4];
  int visits, sum;
  initial begin
    foreach (grid[r, c]) grid[r][c] = r * 10 + c;
    visits = 0;
    sum = 0;
    foreach (grid[r, c]) begin
      visits++;
      sum += grid[r][c];
    end
    // rows contribute 10*(0+1+2)*4 = 120, columns (0+1+2+3)*3 = 18
    if (visits != 12) $display("FAIL: visited %0d elements, expected 12", visits);
    else if (sum != 138) $display("FAIL: sum is %0d, expected 138", sum);
    else $display("PASS");
    $finish;
  end
endmodule
