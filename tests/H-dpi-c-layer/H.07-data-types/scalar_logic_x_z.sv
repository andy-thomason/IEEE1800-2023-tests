/*
:section: H.10.1.1 Scalars of type bit and logic
:summary: Scalar logic passed through DPI encodes 0, 1, z and x as the codes 0, 1, 2 and 3.
:dpi: scalar_logic_x_z.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function int scalar_xz(input logic l);
  logic z = 1'bz, x = 1'bx;
  initial begin
    check(scalar_xz(z) == 2, "z is sv_z");
    check(scalar_xz(x) == 3, "x is sv_x");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
