/*
:section: 6.21 Scope and lifetime
:summary: Variable lifetime defaults from the enclosing subroutine but may be set explicitly per
  variable.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function int static_fn();
    static int calls = 0;
    automatic int fresh = 10;
    calls++;
    fresh++;
    return calls * 100 + fresh;
  endfunction
  function automatic int auto_fn();
    static int calls = 0;
    int fresh = 10;
    calls++;
    fresh++;
    return calls * 100 + fresh;
  endfunction
  initial begin
    check(static_fn() == 111 && static_fn() == 211, "static function: static count, automatic re-initialised");
    check(auto_fn() == 111 && auto_fn() == 211, "automatic function: explicit static keeps its value");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
