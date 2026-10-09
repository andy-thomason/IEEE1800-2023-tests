/*
:section: 7.6 Array assignments
:summary: Copying a dynamic array into a fixed-size target succeeds when both have equal element
  counts.
:description: Only equal-size copies are checked; the run-time error for a size mismatch is tool-
  reported.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int fixed [2][1:4];
  int dyn [] = new [4];
  int nested [3][][];
  initial begin
    foreach (dyn[i]) dyn[i] = i + 1;
    fixed[1] = dyn;
    check(fixed[1][1] == 1 && fixed[1][4] == 4, "dynamic array of equal size into a fixed array");
    nested[2] = new [2];
    nested[2][0] = new [4];
    nested[2][1] = new [4];
    nested[2][1][3] = 77;
    fixed = nested[2];
    check(fixed[1][4] == 77, "dynamic subarrays into a fixed 2-D array");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
