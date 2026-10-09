/*
:section: 6.11.1 Integral types
:summary: Converting 4-state values to 2-state turns every x and z bit into 0.
*/
module top;
  logic [15:0] four;
  bit   [15:0] two;
  int          i;
  initial begin
    four = 16'b1x0z_11xx_zz01_1zx1;
    two = four;
    i = four;
    if (two !== 16'b1000_1100_0001_1001) $display("FAIL: bit vector got %b", two);
    else if (i !== 32'h0000_8C19) $display("FAIL: int got %h", i);
    else $display("PASS");
    $finish;
  end
endmodule
