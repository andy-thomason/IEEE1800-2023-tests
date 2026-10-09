/*
:section: 28.6 bufif1, bufif0, notif1, and notif0 gates
:summary: Three-state gate delays specify rise, fall and turn-off to z, with x using the
  smallest.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic d = 0, c = 1;
  wire y;
  bufif1 #(4, 6, 8) g(y, d, c);
  initial begin
    #20 d = 1;
    #3 check(y === 1'b0, "not risen at 3");
    #2 check(y === 1'b1, "rise delay 4");
    #15 c = 0;
    #7 check(y === 1'b1, "not off at 7");
    #2 check(y === 1'bz, "turn-off delay 8");
    #11 c = 1;
    d = 0;
    #5 check(y === 1'bz, "not fallen at 5");
    #2 check(y === 1'b0, "fall delay 6");
    #13 d = 1'bx;
    #3 check(y === 1'b0, "not x at 3");
    #2 check(y === 1'bx, "transition to x uses the smallest delay (4)");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
