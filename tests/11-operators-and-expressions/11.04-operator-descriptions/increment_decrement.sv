/*
:section: 11.4.2 Increment and decrement operators
:summary: Pre- and post-increment and decrement update the variable and return the new or
  original value respectively.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int i, j;
  real r = 1.5;
  initial begin
    i = 5;
    j = i++;
    check(j == 5 && i == 6, "post-increment");
    j = ++i;
    check(j == 7 && i == 7, "pre-increment");
    j = i--;
    check(j == 7 && i == 6, "post-decrement");
    j = --i;
    check(j == 5 && i == 5, "pre-decrement");
    r++;
    check(r == 2.5, "increment of a real");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
