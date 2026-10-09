/*
:section: 7.4.4 Multidimensional arrays
:summary: In multidimensional arrays, unpacked indices are applied first, then packed ones, and
  subarrays may be assigned.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  bit [3:0][7:0] words [1:3];
  shortint grid [3][2][5];
  shortint shadow [3][2][5];
  shortint rows [4][5];
  initial begin
    words[2] = 32'hAABBCCDD;
    check(words[2][3] == 8'hAA && words[2][0][3:0] == 4'hD, "packed dimensions follow the unpacked index");
    words[3] = words[2] + 1;
    check(words[3] == 32'hAABBCCDE, "4-byte add on an element");
    foreach (grid[p, q, r]) grid[p][q][r] = p * 100 + q * 10 + r;
    foreach (rows[p, r]) rows[p][r] = -r;
    shadow = grid;
    check(shadow[2][1][4] == 214, "whole-array copy");
    shadow[1][0] = rows[3];
    check(shadow[1][0][2] == -2 && shadow[1][1][2] == 112, "one row from another array of matching shape");
    shadow[0] = grid[2];
    check(shadow[0][1][3] == 213 && shadow[0][0][0] == 200, "a 2x5 slab");
    shadow[2][0] = shadow[2][1];
    check(shadow[2][0][0] == 210, "row copied within the same array");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
