/*
:section: 8.26.6.3 Diamond relationship
:summary: Interface methods may be satisfied by inherited virtual methods, and diamond
  inheritance of one interface class is legal.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  interface class named_ic; pure virtual function string name(); endclass
  interface class left_ic extends named_ic; pure virtual function int lval(); endclass
  interface class right_ic extends named_ic; pure virtual function int rval(); endclass
  class base_c;
    virtual function string name(); return "base"; endfunction
  endclass
  class both_c extends base_c implements left_ic, right_ic;
    virtual function int lval(); return 1; endfunction
    virtual function int rval(); return 2; endfunction
  endclass
  both_c b;
  left_ic l;
  right_ic r;
  initial begin
    b = new;
    l = b; r = b;
    check(l.name() == "base" && r.name() == "base", "inherited implementation through both sides of a diamond");
    check(l.lval() + r.rval() == 3, "methods of each interface");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
