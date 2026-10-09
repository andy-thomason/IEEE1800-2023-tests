/*
:section: 6.21 Scope and lifetime
:summary: Class methods are automatic by default even inside a static module, allowing
  recursion.
*/
module static top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class maths;
    function int fib(int n);
      if (n < 2) return n;
      return fib(n - 1) + fib(n - 2);
    endfunction
  endclass
  maths m = new;
  initial begin
    check(m.fib(10) == 55, $sformatf("recursive class method gave %0d", m.fib(10)));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
