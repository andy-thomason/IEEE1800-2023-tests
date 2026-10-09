/*
:section: 7.4.5 Indexing and slicing of arrays
:summary: Writes to a fixed array using an out-of-range index have no effect.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int arr [0:3] = '{1, 2, 3, 4};
  int idx;
  initial begin
    idx = 4;
    arr[idx] = 99;
    idx = -1;
    arr[idx] = 99;
    check(arr[0] == 1 && arr[1] == 2 && arr[2] == 3 && arr[3] == 4, "an invalid write changed the array");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
