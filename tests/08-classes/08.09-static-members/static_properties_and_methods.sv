/*
:section: 8.10 Static methods
:summary: Static properties are shared by all instances and, like static methods, are usable
  without constructing an object.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class tally_c;
    static int made = 0;
    int serial;
    function new(); made++; serial = made; endfunction
    static function int count(); return made; endfunction
  endclass
  tally_c a, b;
  initial begin
    check(tally_c::count() == 0 && tally_c::made == 0, "static members without any object");
    a = new; b = new;
    check(a.made == 2 && b.made == 2 && tally_c::made == 2, "static property is not shared");
    check(a.serial == 1 && b.serial == 2, "instance property");
    check(b.count() == 2, "static method through a handle");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
