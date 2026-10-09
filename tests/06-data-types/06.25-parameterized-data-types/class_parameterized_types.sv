/*
:section: 6.25 Parameterized data types
:summary: Typedefs inside a parameterized virtual class provide parameterized data types via
  class scope.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  virtual class shapes #(parameter type E = logic, parameter int N = 1);
    typedef logic [N-1:0] vec_t;
    typedef E list_t [N];
    typedef struct { vec_t flags; list_t items; } bundle_t;
  endclass
  shapes#(byte, 4)::vec_t v;
  shapes#(.E(shortint), .N(3))::list_t l;
  shapes#(bit [2:0], 2)::bundle_t b;
  initial begin
    check($bits(v) == 4, "vector type from a class with N = 4");
    check($size(l) == 3 && $bits(l[0]) == 16, "array type from a class");
    check($bits(b.flags) == 2 && $bits(b.items[0]) == 3, "struct type from a class");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
