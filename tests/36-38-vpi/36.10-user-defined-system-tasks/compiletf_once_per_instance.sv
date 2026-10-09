/*
:section: 36.10.3 compiletf VPI application routine
:summary: compiletf is called once for each call site of a user-defined system task, not per
  execution.
:vpi: compiletf_once_per_instance.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int n;
  task automatic twice(); $t_marked; endtask
  initial begin
    $t_marked;
    twice();
    twice();
    n = $t_compile_count();
    check(n == 2, $sformatf("compiletf ran %0d times for 2 call sites", n));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
