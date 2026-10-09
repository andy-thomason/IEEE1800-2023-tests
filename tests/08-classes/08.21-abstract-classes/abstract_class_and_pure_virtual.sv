/*
:section: 8.21 Abstract classes and pure virtual methods
:summary: Abstract classes with pure virtual methods cannot be built directly but can be
  constructed via concrete subclasses.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int built = 0;
  virtual class shape_c;
    function new(); built++; endfunction
    pure virtual function int area();
  endclass
  virtual class polygon_c extends shape_c;
  endclass
  class square_c extends polygon_c;
    int side = 3;
    virtual function int area(); return side * side; endfunction
  endclass
  shape_c s;
  square_c q;
  initial begin
    q = new;
    s = q;
    check(s.area() == 9 && built == 1, "pure virtual implemented two levels down");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
