/*
:section: 6.18 User-defined types
:summary: typedef creates new names for existing types, usable in casts and for type parameter
  overrides.
*/
module keeper #(parameter type T = int) (output int n);
  T value;
  assign n = $size(value);
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef int count_t;
  typedef int trio_t [3];
  typedef logic [3:0] nibble_t;
  count_t a = 5, b = 6;
  trio_t t;
  int source [3] = '{1, 2, 3};
  int n;
  keeper #(.T(trio_t)) u(.n(n));
  initial begin
    t = trio_t'(source);
    #1;
    check(a + b == 11 && $bits(a) == 32, "typedef of int");
    check(t[2] == 3, "cast to an unpacked array typedef");
    check(nibble_t'(8'hF7) == 4'h7, "cast to a packed typedef");
    check(n == 3, "unpacked array typedef as a type parameter");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
