/*
:section: 6.23 Type operator
:summary: The expression inside type() is never evaluated, so function side effects do not
  occur.
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
  function automatic logic [6:0] noisy();
    calls++;
    return 7'd1;
  endfunction
  initial begin
    var type(noisy()) v;
    check($bits(v) == 7, "type of a function call");
    check(calls == 0, $sformatf("the expression in type() was evaluated %0d times", calls));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
