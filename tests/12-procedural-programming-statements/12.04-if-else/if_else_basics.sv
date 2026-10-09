/*
:section: 12.4 Conditional if–else statement
:summary: An if condition counts as true only for a nonzero known value; zero, x or z select the
  else branch.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int taken;
  logic [3:0] v;
  initial begin
    v = 4'b0100; taken = 0; if (v) taken = 1; else taken = 2;
    check(taken == 1, "nonzero known value is true");
    v = 4'b1x00; taken = 0; if (v) taken = 1; else taken = 2;
    check(taken == 1, "a vector with a 1 bit and an x is still nonzero");
    v = 4'b00x0; taken = 0; if (v) taken = 1; else taken = 2;
    check(taken == 2, "x without any 1 bit is false");
    v = 4'b0000; taken = 0;
    if (1) if (v) taken = 1; else taken = 3;
    check(taken == 3, "else binds to the closest if");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
