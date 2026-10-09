/*
:section: 8.30.3 Get()
:summary: weak_reference get() returns the referent until cleared, after which it returns null.
:description: Weak references are new in IEEE 1800-2023.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class obj_c; int v = 3; endclass
  obj_c keeper = new;
  weak_reference #(obj_c) w1, w2, wn;
  initial begin
    w1 = new(keeper);
    w2 = new(keeper);
    wn = new(null);
    check(w1 != w2, "two weak references compare equal");
    check(w1.get() == keeper && w2.get() == w1.get(), "get() does not return the referent");
    check(wn.get() == null, "weak reference to null");
    w1.clear();
    check(w1.get() == null && w2.get() == keeper, "clear() affected the wrong reference");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
