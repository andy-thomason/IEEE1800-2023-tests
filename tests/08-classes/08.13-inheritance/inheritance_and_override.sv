/*
:section: 8.14 Overridden members
:summary: Subclass handles may stand in for base handles, and virtual methods dispatch on the
  actual object type.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class base_c;
    int a = 1;
    function int plain(); return 10; endfunction
    virtual function int dyn(); return 100; endfunction
  endclass
  class derived_c extends base_c;
    int a = 2;
    function int plain(); return 20; endfunction
    virtual function int dyn(); return 200; endfunction
  endclass
  base_c bh;
  derived_c dh;
  initial begin
    dh = new;
    bh = dh;
    check(bh.a == 1 && dh.a == 2, "property lookup uses the handle type");
    check(bh.plain() == 10 && dh.plain() == 20, "non-virtual call uses the handle type");
    check(bh.dyn() == 200, "virtual call does not use the object type");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
