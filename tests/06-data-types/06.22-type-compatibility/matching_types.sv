/*
:section: 6.22.1 Matching types
:summary: Built-in types, typedef renames and same-declaration anonymous structs match; separate
  typedefs do not.
:description: Matching is observed with type() comparisons, which are equal only for matching types
  (6.23).
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef bit flag_t;
  typedef flag_t flag2_t;
  struct packed { int lo; int hi; } s1, s2;
  struct packed { int lo; int hi; } s3;
  typedef struct packed { int lo; int hi; } span_t;
  typedef struct packed { int lo; int hi; } other_span_t;
  span_t sp1, sp2;
  other_span_t osp;
  initial begin
    check(type(int) == type(int), "a built-in type does not match itself");
    check(type(flag_t) == type(bit) && type(flag2_t) == type(bit), "typedef renames do not match");
    check(type(s1) == type(s2), "anonymous struct objects in one declaration do not match");
    check(type(s1) != type(s3), "anonymous structs from two declarations match");
    check(type(sp1) == type(sp2) && type(sp1) == type(span_t), "objects of one struct typedef do not match");
    check(type(sp1) != type(osp), "two struct typedefs with the same layout match");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
