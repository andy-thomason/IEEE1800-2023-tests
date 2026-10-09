/*
:section: 5.7.1 Integer literal constants
:summary: White space is permitted between the size, base specifier and digits of a based
  literal.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  initial begin
    check(12 'o 7_7 == 12'o77, "spaces around 'o");
    check(8'h  3C == 8'd60, "spaces before the value");
    check(16 'shF0F0 === 16'shF0F0, "space between size and 'sh");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
