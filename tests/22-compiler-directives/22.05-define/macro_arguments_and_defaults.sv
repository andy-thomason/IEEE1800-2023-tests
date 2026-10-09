/*
:section: 22.5.1 `define
:summary: Macro formal arguments can have defaults that apply when an actual argument is omitted
  or left empty.
*/
`define SUM3(a, b = 20, c = 10) ((a) + (b) + (c))
`define TWICE(x) (2 * x)
`define PAIR(p) (p[0] + p[1])

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  function automatic int first2(int v [2]); return v[0] + v[1]; endfunction
  initial begin
    check(`SUM3(1, 2, 3) == 6, "three arguments");
    check(`SUM3(1, , 3) == 24, "empty middle argument takes its default");
    check(`SUM3(1) == 31, "missing arguments take their defaults");
    check(`TWICE((4 + 1)) == 10, "parenthesised argument containing an operator");
    check(first2('{1, 2}) == 3, "argument with a comma inside braces");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
