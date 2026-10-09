/*
:section: 21.2.1.3 Unknown and high-impedance values
:summary: Decimal output shows x or z for fully unknown values and X or Z for partly unknown
  ones.
:expect: [x][z][X][Z]
  [Xxz1]
  [1XZ]
  [1xz0]
*/
module top;
  initial begin
    $display("[%0d][%0d][%0d][%0d]", 4'bxxxx, 4'bzzzz, 4'b10x1, 4'b1z01);
    $display("[%h]", 16'b1x0z_xxxx_zzzz_0001);
    $display("[%o]", 9'b001_1x1_zz0);
    $display("[%b]", 4'b1xz0);
    $finish;
  end
endmodule
