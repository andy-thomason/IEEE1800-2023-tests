/*
:section: 9.3.2 Parallel blocks
:summary: fork with join waits for all children, join_any for one, and join_none continues
  immediately.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int done = 0;
  initial begin
    fork
      #3 done++;
      #1 done++;
    join
    check($time == 3 && done == 2, "join did not wait for all");
    fork
      #4 done++;
      #1 done++;
    join_any
    check($time == 4 && done == 3, "join_any did not resume after the first");
    fork
      #2 done++;
    join_none
    check($time == 4, "join_none blocked");
    #5;
    check(done == 5, "processes left running by join_any/join_none did not finish");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
