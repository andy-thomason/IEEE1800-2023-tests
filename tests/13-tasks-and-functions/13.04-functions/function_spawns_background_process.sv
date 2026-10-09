/*
:section: 13.4.4 Background processes spawned by function calls
:summary: fork-join_none and nonblocking assignments in a function schedule work without
  blocking the caller.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int later = 0, nb = 0;
  event done;
  function void start();
    nb <= 4;
    fork
      #3 later = 9;
    join_none
  endfunction
  initial begin
    start();
    check($time == 0 && later == 0, "the function blocked");
    #1 check(nb == 4, "nonblocking assignment from a function");
    #3 check(later == 9, "process spawned by a function");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
