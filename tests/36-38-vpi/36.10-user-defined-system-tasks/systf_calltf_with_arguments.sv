/*
:section: 36.10.1 User-defined system task and system function names
:summary: calltf runs on every execution of a user system task or function, whose name begins
  with $.
:vpi: systf_calltf_with_arguments.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int a = 20, b = 22, calls_seen;
  int result;
  initial begin
    result = $t_add(a, b);
    $t_bump$2(calls_seen);
    $t_bump$2(calls_seen);
    check(result == 42, $sformatf("system function result %0d", result));
    check(calls_seen == 2, "calltf ran once per execution of the task");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
