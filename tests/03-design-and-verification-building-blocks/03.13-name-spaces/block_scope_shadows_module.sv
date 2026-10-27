/*
:section: 3.13 Name spaces
:summary: Names declared inside functions, tasks and blocks hide same-named module-level
  declarations.
:description: Each block, function and task opens its own name space, so redeclaring an outer name
  there is legal.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int value = 1;
  function automatic int shadow_in_function();
    int value = 2;
    return value;
  endfunction
  task automatic shadow_in_task(output int seen);
    int value = 3;
    seen = value;
  endtask
  initial begin : named_block
    static int value = 4;
    int seen;
    shadow_in_task(seen);
    check(shadow_in_function() == 2, "function local did not shadow module variable");
    check(seen == 3, "task local did not shadow module variable");
    check(value == 4, "named block local did not shadow module variable");
    check(top.value == 1, "module variable was changed");
    begin
      static int value = 5;
      check(value == 5, "unnamed block local did not shadow outer block variable");
    end
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
