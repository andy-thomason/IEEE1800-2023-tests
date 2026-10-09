/*
:section: 6.6.7 User-defined nettypes
:summary: A nettype resolution function computes the net value from its driver values whenever a
  driver changes.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function automatic int max_of(input int drivers []);
    max_of = 0;
    foreach (drivers[i])
      if (drivers[i] > max_of) max_of = drivers[i];
  endfunction
  nettype int max_net with max_of;
  max_net level;
  int a = 3, b = 9;
  assign level = a;
  assign level = b;
  initial begin
    #1 check(level == 9, $sformatf("max of 3 and 9 = %0d", level));
    a = 20;
    #1 check(level == 20, "resolution was not re-run when a driver changed");
    force level = 1;
    #1 check(level == 1, "force did not override");
    release level;
    #1 check(level == 20, "release did not return to the resolved value");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
