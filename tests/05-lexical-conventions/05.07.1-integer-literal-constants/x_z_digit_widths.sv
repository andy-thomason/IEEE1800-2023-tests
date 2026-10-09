/*
:section: 5.7.1 Integer literal constants
:summary: Each x or z digit spans 4 bits in hex, 3 in octal, 1 in binary.
*/
module top;
  logic [11:0] h;
  logic [8:0]  o;
  logic [3:0]  b;
  initial begin
    h = 12'h3x9;
    o = 9'o5z1;
    b = 4'b1x0z;
    if (h !== 12'b0011_xxxx_1001) $display("FAIL: 12'h3x9 gave %b", h);
    else if (o !== 9'b101_zzz_001) $display("FAIL: 9'o5z1 gave %b", o);
    else if (b !== {1'b1, 1'bx, 1'b0, 1'bz}) $display("FAIL: 4'b1x0z gave %b", b);
    else $display("PASS");
    $finish;
  end
endmodule
