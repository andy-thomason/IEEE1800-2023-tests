/*
:section: 11.12 Let construct
:summary: A let names a reusable expression with optional typed formals, defaults and references
  to surrounding variables.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int offset = 100;
  let plus_offset(v) = v + offset;
  let pick(a, b = 7) = a > b ? a : b;
  let as_byte(byte v) = v;
  let three = 3;
  initial begin
    check(plus_offset(5) == 105, "let using a variable from its declaration scope");
    check(pick(3) == 7 && pick(9) == 9, "default argument");
    check(as_byte(300) == 44, "typed argument is cast");
    check(three == 3, "let without arguments");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
