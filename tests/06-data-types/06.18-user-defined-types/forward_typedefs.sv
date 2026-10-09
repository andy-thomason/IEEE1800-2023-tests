/*
:section: 6.18 User-defined types
:summary: Forward typedefs for enum, struct, union, class or untyped names may precede the full
  definition.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef enum colour_t;
  typedef struct point_t;
  typedef union bits_t;
  typedef class node;
  typedef anything_t;
  typedef anything_t;
  class node;
    node next;
    int id;
  endclass
  typedef enum {RED, GREEN} colour_t;
  typedef struct { int x, y; } point_t;
  typedef union packed { logic [7:0] b; logic [1:0][3:0] n; } bits_t;
  typedef logic [2:0] anything_t;
  typedef struct point_t;
  colour_t c = GREEN;
  point_t p;
  bits_t u;
  anything_t a;
  node first;
  initial begin
    p.x = 2; p.y = 3;
    u.b = 8'hC4;
    first = new;
    first.next = new;
    first.next.id = 9;
    check(c == GREEN && p.x + p.y == 5, "forward enum and struct");
    check(u.n[1] == 4'hC, "forward union");
    check($bits(a) == 3, "forward typedef with no basic type");
    check(first.next.id == 9, "forward class");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
