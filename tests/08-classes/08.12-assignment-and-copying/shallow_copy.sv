/*
:section: 8.12 Assignment, renaming, and copying
:summary: A shallow copy via new on an existing object duplicates properties but shares nested
  object handles without running constructors.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int constructions = 0;
  class inner_c; int v = 1; endclass
  class outer_c;
    int n = 3;
    string label = "orig";
    inner_c child = new;
    function new(); constructions++; endfunction
  endclass
  outer_c a, b;
  initial begin
    a = new;
    a.n = 30;
    a.label = "changed";
    b = new a;
    check(constructions == 1, "the shallow copy called the constructor");
    check(b != a && b.n == 30 && b.label == "changed", "properties were not copied (or were re-initialised)");
    check(b.child == a.child, "the nested object was copied rather than its handle");
    b.n = 4;
    b.child.v = 8;
    check(a.n == 30 && a.child.v == 8, "copy is not independent / nested object is not shared");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
