/*
:section: 11.2.2 Aggregate expressions
:summary: Unpacked structures and arrays act as aggregate values that can be assigned and
  compared for equality.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { int a; byte b; } s_t;
  s_t x, y;
  int p [3], q [0:2];
  initial begin
    x.a = 1; x.b = 2;
    y = x;
    check(x == y, "equal structs");
    y.b = 3;
    check(x != y, "unequal structs");
    p = '{1, 2, 3}; q = '{1, 2, 3};
    check(p == q, "equal arrays with different ranges");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
