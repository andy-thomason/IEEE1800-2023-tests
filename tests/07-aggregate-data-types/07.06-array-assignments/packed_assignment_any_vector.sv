/*
:section: 7.6 Array assignments
:summary: Any vector value may be assigned to a packed array regardless of the target's bounds.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  bit [1:4][1:2] odd_bounds;
  bit [0:7] reversed;
  initial begin
    odd_bounds = 8'b1001_0110;
    check(odd_bounds[1] == 2'b10 && odd_bounds[4] == 2'b10, "vector into [1:4][1:2]");
    reversed = 8'h81;
    check(reversed[0] == 1'b1 && reversed[7] == 1'b1 && reversed[1] == 1'b0, "vector into [0:7]");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
