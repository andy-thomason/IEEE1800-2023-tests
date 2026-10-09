/*
:section: 13.4.1 Return values and void functions
:summary: A function returns its value either through return or by assigning to its own name.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function int by_name(int v); by_name = v * 2; endfunction
  function int by_return(int v); return v * 3; endfunction
  function int both(int v); both = 1; return v; endfunction
  function logic [3:0] implicit_width(input [3:0] a); implicit_width = a + 1; endfunction
  int side = 0;
  function int bump(); side++; return side; endfunction
  initial begin
    check(by_name(4) == 8 && by_return(4) == 12 && both(9) == 9, "return forms");
    check($bits(implicit_width(4'hF)) == 4 && implicit_width(4'hF) == 0, "return type width");
    void'(bump());
    check(side == 1, "void cast call");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
