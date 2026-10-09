/*
:section: 7.4.6 Operations on arrays
:summary: Arrays support whole copy, element and slice assignment, and equality comparison.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int a [6], b [6];
  logic signed [3:0] s [2];
  int i = 1, j = 3;
  initial begin
    foreach (b[k]) b[k] = k + 10;
    a = b;
    check(a == b, "whole-array copy and equality");
    a[2] = b[5];
    check(a != b && a[2] == 15, "element copy");
    a[i +: 2] = b[j +: 2];
    check(a[1] == 13 && a[2] == 14, "slice copy");
    check(a[i +: 2] == b[j +: 2], "slice equality");
    s[0] = 4'b1111;
    check(s[0] < 0, "elements of a signed unpacked array are not signed");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
