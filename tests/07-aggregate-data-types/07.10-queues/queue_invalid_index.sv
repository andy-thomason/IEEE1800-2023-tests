/*
:section: 7.10.1 Queue operators
:summary: Invalid queue indices return defaults on read and are ignored on write, except [$+1].
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] q [$] = {4'd1, 4'd2};
  integer xi = 'x;
  initial begin
    check(q[5] === 4'bxxxx && q[xi] === 4'bxxxx, "invalid reads");
    q[5] = 4'd9;
    q[xi] = 4'd9;
    check(q.size() == 2 && q[0] == 1 && q[1] == 2, "an invalid write was not ignored");
    q[$ + 1] = 4'd3;
    check(q.size() == 3 && q[2] == 3, "q[$+1] did not append");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
