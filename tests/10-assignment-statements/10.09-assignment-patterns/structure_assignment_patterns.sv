/*
:section: 10.9.2 Structure assignment patterns
:summary: Structure assignment patterns may set members by name, by type, or through a default
  key.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { int x; byte tag; } inner_t;
  typedef struct { int x; inner_t sub; real scale; byte flag; } outer_t;
  outer_t o;
  initial begin
    o = '{x: 1, default: 0};
    check(o.x == 1 && o.sub.x == 0, "member key sets only the top-level member");
    o = '{byte: 8'd7, default: 2};
    check(o.flag == 7 && o.sub.tag == 7, "type key applies recursively");
    check(o.x == 2 && o.sub.x == 2 && o.scale == 2.0, "default applies to the remaining members");
    o = '{x: 5, sub: '{x: 6, tag: 1}, scale: 0.5, flag: 3};
    check(o.sub.x == 6 && o.scale == 0.5, "all members by name");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
