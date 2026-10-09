/*
:section: 13.3 Tasks
:summary: Task calls pass inputs, wait for completion including delays, then copy outputs back
  to the caller.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int r1, r2;
  task automatic add_later(input int a, b, output int sum);
    #3 sum = a + b;
  endtask
  task old_style;
    input [7:0] x;
    output [7:0] y;
    y = x + 1;
  endtask
  task nothing(); endtask
  initial begin
    add_later(2, 5, r1);
    check(r1 == 7 && $time == 3, "control returns after the task's delay");
    old_style(8'd9, r2);
    check(r2 == 10, "port declarations in the task body");
    nothing();
    check($time == 3, "an empty task");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
