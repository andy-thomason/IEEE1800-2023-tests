/*
:section: 13.5.5 Optional argument list
:summary: Tasks and void functions whose arguments are all defaulted or absent may be called
  without parentheses.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int n = 0;
  function void bump(int by = 1); n += by; endfunction
  task tick(); n += 10; endtask
  initial begin
    bump;
    tick;
    check(n == 11, "calls without parentheses");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
