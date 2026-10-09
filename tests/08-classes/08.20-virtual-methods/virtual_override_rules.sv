/*
:section: 8.20 Virtual methods
:summary: Once virtual, a method stays virtual in subclasses even without the keyword, and
  covariant class returns are allowed.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  typedef int count_t;
  class level1_c;
    function int f(); return 1; endfunction
  endclass
  class level2_c extends level1_c;
    virtual function int f(); return 2; endfunction
    virtual function level2_c make(count_t n); return this; endfunction
  endclass
  class level3_c extends level2_c;
    function int f(); return 3; endfunction
    virtual function level3_c make(int n); return this; endfunction
  endclass
  level1_c h1;
  level2_c h2;
  level3_c h3;
  initial begin
    h3 = new;
    h2 = h3;
    h1 = h3;
    check(h1.f() == 1, "a call through the base where f is non-virtual");
    check(h2.f() == 3, "an override without the virtual keyword is not virtual");
    check(h2.make(1) == h3, "covariant return type");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
