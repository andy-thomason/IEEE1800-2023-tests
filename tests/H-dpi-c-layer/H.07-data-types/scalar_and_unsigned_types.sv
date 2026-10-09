/*
:section: H.7.4 Basic types
:summary: Basic types map to fixed C types; unsigned byte and unsigned shortint inputs arrive as
  C unsigned values.
:dpi: scalar_and_unsigned_types.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" function int scalar_code(input logic l);
  import "DPI-C" function int ubyte_plus(input byte unsigned b, input shortint unsigned s);
  import "DPI-C" function int bits8(input bit [7:0] b);
  initial begin
    check(scalar_code(1'b0) == 0 && scalar_code(1'b1) == 1, "known scalars");
    check(ubyte_plus(8'd200, 16'd60000) == 60200, "unsigned byte and shortint passed by value");
    check(bits8(8'd200) == 200, "bit [7:0] passed by reference");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
