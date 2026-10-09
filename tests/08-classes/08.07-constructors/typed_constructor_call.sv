/*
:section: 8.8 Typed constructor calls
:summary: A typed constructor call such as subclass::new builds an object of the named type,
  optionally with arguments.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  class shape_c; virtual function int sides(); return 0; endfunction endclass
  class tri_c extends shape_c;
    int scale;
    function new(int s = 1); scale = s; endfunction
    virtual function int sides(); return 3; endfunction
  endclass
  class box_c #(int N = 4) extends shape_c;
    virtual function int sides(); return N; endfunction
  endclass
  shape_c s;
  initial begin
    s = tri_c::new(7);
    check(s.sides() == 3, "typed constructor did not create a tri_c");
    begin
      tri_c t;
      check($cast(t, s) && t.scale == 7, "typed constructor arguments");
    end
    s = box_c#(6)::new;
    check(s.sides() == 6, "typed constructor of a parameterized class");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
