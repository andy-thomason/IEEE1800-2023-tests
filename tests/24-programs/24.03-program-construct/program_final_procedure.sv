/*
:section: 24.3 The program construct
:summary: A program may hold classes, functions, data, initial procedures and a final procedure.
:timeout: 30
*/
module top;
  p u();
endmodule
program p;
  class Counter;
    int n;
    function void bump(); n++; endfunction
  endclass
  Counter c = new;
  function automatic int twice(int x); return 2 * x; endfunction
  initial begin
    c.bump();
    c.bump();
  end
  final begin
    if (twice(c.n) == 4) $display("PASS");
    else $display("FAIL: program state at final was %0d", c.n);
  end
endprogram
