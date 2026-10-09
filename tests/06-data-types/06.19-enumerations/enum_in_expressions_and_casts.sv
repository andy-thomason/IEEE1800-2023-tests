/*
:section: 6.19.4 Enumerated types in numerical expressions
:summary: Enums in expressions become their base type, and casting to an enum skips value
  checks.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef enum {ZERO, ONE, TWO, THREE} num_t;
  typedef enum {A, B, C} abc_t;
  num_t n = TWO;
  abc_t x = C;
  int i;
  initial begin
    i = n * 5;               check(i == 10, "enum in multiplication");
    i = n + x;               check(i == 4, "two enums of different types added as int");
    check(1 < n, "enum in a relational expression");
    n = num_t'(n + 1);       check(n == THREE, "cast back to enum");
    n = num_t'(9);           check(int'(n) == 9, "out-of-range cast is not checked");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
