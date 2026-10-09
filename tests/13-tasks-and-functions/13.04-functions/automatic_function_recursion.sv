/*
:section: 13.4.2 Static and automatic functions
:summary: Automatic functions may call themselves recursively, while static function variables
  persist between calls.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function automatic int fact(int n);
    if (n <= 1) return 1;
    return n * fact(n - 1);
  endfunction
  function int static_sum(int n);
    int acc;
    acc += n;
    return acc;
  endfunction
  initial begin
    check(fact(7) == 5040, "recursive automatic function");
    check(top.fact(4) == 24, "automatic function called by hierarchical name");
    void'(static_sum(3));
    check(static_sum(4) == 7, "a static function variable kept its value");
    check(top.static_sum.acc == 7, "static function variable by hierarchical name");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
