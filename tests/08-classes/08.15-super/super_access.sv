/*
:section: 8.15 Super
:summary: Inside a derived class, super selects members inherited from the immediate parent
  class.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class a_c; int depth = 1; virtual function int val(); return 1; endfunction endclass
  class b_c extends a_c; endclass
  class c_c extends b_c;
    int depth = 3;
    virtual function int val(); return 30 + super.val(); endfunction
    function int up(); return super.depth; endfunction
  endclass
  c_c c;
  initial begin
    c = new;
    check(c.val() == 31, "super.val() reached an inherited method");
    check(c.up() == 1, "super.depth from an inherited property");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
