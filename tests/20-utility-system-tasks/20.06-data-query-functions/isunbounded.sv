/*
:section: 20.6.3 Range system function
:summary: $isunbounded returns true only for a parameter whose value is $.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  parameter int open_ended = $;
  parameter int closed = 4;
  initial begin
    check($isunbounded(open_ended) == 1, "$isunbounded of $");
    check($isunbounded(closed) == 0, "$isunbounded of 4");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
