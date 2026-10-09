/*
:section: 26.2 Package declarations
:summary: Packages may hold parameters, typedefs, variables, functions and tasks that importers
  can use.
*/
package shapes;
  parameter int SIDES = 4;
  typedef struct packed { logic [7:0] w, h; } rect_t;
  int created;
  function automatic int area(rect_t r); return r.w * r.h; endfunction
  task automatic note(); created++; endtask
endpackage

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  shapes::rect_t r = {8'd3, 8'd5};
  initial begin
    #1;
    shapes::note();
    check(shapes::area(r) == 15, "package function and type");
    check(shapes::SIDES == 4 && shapes::created == 1, "package parameter and variable");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
