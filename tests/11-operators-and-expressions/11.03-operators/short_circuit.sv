/*
:section: 11.3.5 Operator expression short circuiting
:summary: The &&, ||, -> and ?: operators skip evaluating operands whose value cannot affect the
  result.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int calls = 0;
  function automatic bit noisy(bit v); calls++; return v; endfunction
  bit r;
  initial begin
    r = 0 && noisy(1);   check(calls == 0, "&& evaluated its second operand");
    r = 1 || noisy(1);   check(calls == 0, "|| evaluated its second operand");
    r = 0 -> noisy(1);   check(calls == 0, "-> evaluated its second operand");
    r = 1 ? 1 : noisy(1); check(calls == 0, "?: evaluated the unused operand");
    r = 1 && noisy(1);   check(calls == 1 && r, "&& with a true first operand");
    r = noisy(0) & noisy(1);
    check(calls == 3, "& short-circuited");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
