/*
:section: 6.21 Scope and lifetime
:summary: Declaring a module automatic makes its subroutines automatic, allowing recursive
  functions.
:description: Recursion only works if the function's arguments are automatic.
*/
module automatic top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function int factorial(int n);
    if (n <= 1) return 1;
    return n * factorial(n - 1);
  endfunction
  initial begin
    check(factorial(6) == 720, $sformatf("recursive function in an automatic module gave %0d", factorial(6)));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
