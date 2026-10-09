/*
:section: 13.5.3 Default argument values
:summary: Default argument expressions are evaluated in the declaring scope each time a call
  omits that argument.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int base = 10;
  int evals = 0;
  function int note(); evals++; return base; endfunction
  function automatic int calc(int j = 0, int k = note(), int m = 2); return j + k + m; endfunction
  initial begin
    check(calc() == 12 && evals == 1, "all defaults");
    check(calc(1, 5) == 8 && evals == 1, "a supplied argument does not evaluate its default");
    check(calc(1, , 7) == 18 && evals == 2, "skipped middle argument");
    base = 20;
    check(calc(.m(0)) == 20, "default re-evaluated at each call");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
