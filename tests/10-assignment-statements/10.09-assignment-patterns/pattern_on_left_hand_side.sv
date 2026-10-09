/*
:section: 10.9 Assignment patterns
:summary: A positional assignment pattern used as an assignment target must match each element's
  bit width.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { byte hi; byte lo; } pair_t;
  pair_t src;
  byte a, b;
  initial begin
    src.hi = 8'h12; src.lo = 8'h34;
    '{a, b} = src;
    check(a == 8'h12 && b == 8'h34, "pattern as an assignment target");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
