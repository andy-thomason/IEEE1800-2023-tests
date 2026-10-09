/*
:section: 8.4 Objects (class instance)
:summary: Object handles support only equality, case equality, conditional and assignment
  operators against compatible handles or null.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class pkt; int id; function new(int i = 0); id = i; endfunction endclass
  class big_pkt extends pkt; function new(int i = 0); super.new(i); endfunction endclass
  pkt a, b, none;
  big_pkt bp;
  initial begin
    a = new(1);
    b = a;
    check(a == b && a === b, "copies of a handle are not equal");
    b = new(1);
    check(a != b && a !== b, "two objects with equal contents compare equal");
    check(none == null && none === null, "default handle is not null");
    bp = new(4);
    a = bp;
    check(a == bp && a.id == 4, "derived handle assigned to a base handle");
    b = (a.id > 3) ? a : null;
    check(b == bp, "conditional operator on handles");
    a = null;
    check(a == null, "assignment of null");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
