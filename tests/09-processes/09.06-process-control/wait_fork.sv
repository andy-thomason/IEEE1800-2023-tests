/*
:section: 9.6.1 Wait fork statement
:summary: wait fork blocks until all direct child processes of the current process have
  finished.
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
    fork #3 done++; join_none
    fork #5 done++; join_none
    wait fork;
    check(done == 2 && $time == 5, "wait fork returned early");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
