/*
:section: 11.4.3.1 Arithmetic expressions with unsigned and signed types
:summary: Without explicit qualifiers, byte, shortint, int, integer, longint hold signed values
  while all other types hold unsigned values.
:description: All-ones values compare below zero only when the type is signed.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  byte        b  = -1;
  shortint    sh = -1;
  int         i  = -1;
  integer     ig = -1;
  longint     l  = -1;
  bit   [7:0] bv = '1;
  logic [7:0] lv = '1;
  reg   [7:0] rv = '1;
  time        t  = '1;
  wire  [7:0] w  = 8'hFF;
  logic signed   [7:0] explicit_signed = '1;
  int unsigned         explicit_unsigned = '1;
  initial begin
    #1;
    check(b < 0, "byte is not signed");
    check(sh < 0, "shortint is not signed");
    check(i < 0, "int is not signed");
    check(ig < 0, "integer is not signed");
    check(l < 0, "longint is not signed");
    check(bv > 0, "bit [7:0] is not unsigned");
    check(lv > 0, "logic [7:0] is not unsigned");
    check(rv > 0, "reg [7:0] is not unsigned");
    check(t > 0, "time is not unsigned");
    check(w > 0, "wire [7:0] is not unsigned");
    check(explicit_signed < 0, "logic signed [7:0] is not signed");
    check(explicit_unsigned > 0, "int unsigned is not unsigned");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
