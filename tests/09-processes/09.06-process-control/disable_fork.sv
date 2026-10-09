/*
:section: 9.6.3 Disable fork statement
:summary: disable fork kills every active descendant process of the calling process.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int finished = 0;
  initial begin
    fork
      #2 finished++;
      #8 finished += 10;
      begin fork #9 finished += 100; join_none #4; end
    join_any
    check($time == 2, "join_any did not resume when the first branch finished");
    disable fork;
    #10;
    check(finished == 1, $sformatf("finished = %0d; disable fork should stop the other branches and the grandchild", finished));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
