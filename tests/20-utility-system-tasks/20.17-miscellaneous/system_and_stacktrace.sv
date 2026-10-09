/*
:section: 20.17 Miscellaneous tasks and functions
:summary: $system runs a shell command and returns its exit code, and $stacktrace reports the
  active call stack.
:description: $stacktrace is new in IEEE 1800-2023; its content is implementation dependent.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int rc;
  string trace;
  function automatic string inner(); return $stacktrace; endfunction
  initial begin
    rc = $system("exit 0");
    check(rc == 0, $sformatf("$system of a successful command returned %0d", rc));
    rc = $system("exit 3");
    check(rc != 0, "$system of a failing command returned 0");
    $stacktrace;
    trace = inner();
    check(trace.len() >= 0, "$stacktrace as a function");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
