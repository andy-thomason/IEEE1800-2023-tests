/*
:section: 23.8.1 Task and function name resolution
:summary: Task and function calls search upward and then the compilation unit before searching
  higher module scopes.
*/
function automatic int unit_fn(); return 1; endfunction
module child;
  int r1, r2;
  initial begin
    r1 = unit_fn();
    r2 = helper();
  end
endmodule
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function automatic int helper(); return 2; endfunction
  child c();
  initial begin
    #1;
    check(c.r1 == 1, "compilation-unit function");
    check(c.r2 == 2, "function found upward in the instantiating module");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
