/*
:section: 35.5.1.2 input, output, and inout arguments
:summary: DPI output and inout arguments return changes to the caller while input arguments stay
  unchanged.
:dpi: argument_directions.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function void shuffle(input int a, output int b, inout int c, input int arr[4]);
  int a = 4, b = 0, c = 10;
  int arr [4] = '{1, 2, 3, 4};
  initial begin
    shuffle(a, b, c, arr);
    check(a == 4, "input scalar unchanged");
    check(b == 8, $sformatf("output written: %0d", b));
    check(c == 14, $sformatf("inout updated: %0d", c));
    check(arr[0] == 1, "input array unchanged");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
