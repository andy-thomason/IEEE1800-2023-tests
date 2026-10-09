/*
:section: 6.22.3 Assignment compatible
:summary: Types with implicit conversions, such as integral, enum and real types, may be
  assigned to each other.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef enum {NORTH, EAST, SOUTH} dir_t;
  typedef struct packed { logic [3:0] a; logic [3:0] b; } pair_t;
  dir_t d = SOUTH;
  pair_t p;
  int i;
  real r;
  byte tiny;
  initial begin
    i = d;              check(i == 2, "enum to int");
    p = 16'hABCD;       check(p.a == 4'hC && p.b == 4'hD, "integral to packed struct truncates");
    tiny = 300;         check(tiny == 44, "int to byte truncates");
    r = 7;              check(r == 7.0, "int to real");
    i = 2.6;            check(i == 3, "real to int rounds");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
