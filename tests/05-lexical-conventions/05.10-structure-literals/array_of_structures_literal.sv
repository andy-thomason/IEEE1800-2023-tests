/*
:section: 5.10 Structure literals
:summary: Arrays of structs use nested braces per level, and replication can fill all struct
  members.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef struct { int id; real weight; } item_t;
  item_t items [0:1] = '{'{5, 0.25}, '{6, 0.75}};
  struct { int p, q, r; } triple = '{3{7}};
  initial begin
    check(items[0].id == 5 && items[0].weight == 0.25, "first element");
    check(items[1].id == 6 && items[1].weight == 0.75, "second element");
    check(triple.p == 7 && triple.q == 7 && triple.r == 7, "replication into three members");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
