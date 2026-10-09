/*
:section: 8.16 Casting
:summary: Upcasting is always allowed, and $cast can downcast when the referenced object really
  has the subclass type.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class animal_c; endclass
  class dog_c extends animal_c; endclass
  class cat_c extends animal_c; endclass
  class rock_c; endclass
  animal_c a;
  dog_c d;
  cat_c c;
  initial begin
    d = new;
    a = d;
    check($cast(d, a) == 1, "downcast to the actual type failed");
    check($cast(c, a) == 0, "downcast to the wrong subclass succeeded");
    a = null;
    check($cast(d, a) == 1 && d == null, "null downcast between related types failed");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
