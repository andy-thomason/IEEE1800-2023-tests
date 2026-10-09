/*
:section: 8.20 Virtual methods
:summary: The :initial, :extends and :final method specifiers control whether a method starts,
  overrides, or ends a virtual chain.
:description: Method specifiers :initial, :extends and :final are new in IEEE 1800-2023.
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
    virtual function int a(); return 1; endfunction
    function :initial int b(); return 2; endfunction
    virtual function :final int c(); return 3; endfunction
  endclass
  class sub_c extends base_c;
    virtual function :extends int a(); return 10; endfunction
  endclass
  base_c h;
  sub_c s;
  initial begin
    s = new;
    h = s;
    check(h.a() == 10 && h.b() == 2 && h.c() == 3, "methods with :initial, :extends and :final");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
