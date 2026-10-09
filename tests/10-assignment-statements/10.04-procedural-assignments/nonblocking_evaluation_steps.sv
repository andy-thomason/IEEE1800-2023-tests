/*
:section: 10.4.2 Nonblocking procedural assignments
:summary: Nonblocking assignments sample now and update later, and multiple updates to one
  variable apply in order.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] x = 4'd1, y = 4'd2;
  bit le;
  logic [7:0] shift_reg = 8'h01;
  initial begin
    x <= y;
    y <= x;
    le <= x <= y;
    shift_reg <= shift_reg << 1;
    shift_reg <= shift_reg << 2;
    #1;
    check(x == 2 && y == 1, "swap with nonblocking assignments");
    check(le == 1, "<= as an operator inside a nonblocking assignment");
    check(shift_reg == 8'h04, "the last of two nonblocking assignments did not win");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
