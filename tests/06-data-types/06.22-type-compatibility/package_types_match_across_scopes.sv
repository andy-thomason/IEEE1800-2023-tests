/*
:section: 6.22.1 Matching types
:summary: A struct typedef imported from a package is the same type in every instance.
*/
package shapes;
  typedef struct { int w; int h; } box_t;
endpackage

typedef struct { int r; } disc_t;

module holder;
  import shapes::box_t;
  box_t b;
  disc_t d;
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  holder h1();
  holder h2();
  initial begin
    h1.b.w = 3; h1.b.h = 4; h1.d.r = 5;
    h2.b = h1.b;
    h2.d = h1.d;
    check(h2.b.w * h2.b.h == 12 && h2.d.r == 5, "package and compilation-unit types across instances");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
