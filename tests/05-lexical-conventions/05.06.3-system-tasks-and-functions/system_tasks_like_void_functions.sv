/*
:section: 5.6.3 System tasks and system functions
:summary: Standard system tasks take no simulation time and are usable wherever a void function
  call is allowed.
:description: A system task is called from inside a function, where time-consuming tasks are not
  allowed.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function automatic int noisy(int v);
    $display("noisy called with %0d", v);
    return v + 1;
  endfunction
  initial begin
    check(noisy(4) == 5, "function calling a system task");
    check($time == 0, "a system task consumed time");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
