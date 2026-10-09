/*
:section: 7.2.1 Packed structures
:summary: A packed struct acts as one vector whose first member occupies the most significant
  bits.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  struct packed { bit [3:0] hi; bit [7:0] mid; bit [3:0] lo; } u;
  struct packed signed { bit [3:0] top4; bit [3:0] low4; } s;
  initial begin
    u = 16'hA5C3;
    check(u.hi == 4'hA && u.mid == 8'h5C && u.lo == 4'h3, "first member is not the most significant");
    check(u[11:4] == 8'h5C && u[15] == 1'b1, "bit and part selects of a packed struct");
    check(u + 1 == 16'hA5C4, "arithmetic on a packed struct");
    check(u > 0, "unsigned packed struct compared as negative");
    s = 8'hF0;
    check(s < 0, "signed packed struct is not signed");
    check((s >>> 4) == -1, "signed packed struct did not shift arithmetically");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
