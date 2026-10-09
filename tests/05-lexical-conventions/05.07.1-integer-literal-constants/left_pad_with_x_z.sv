/*
:section: 5.7.1 Integer literal constants
:summary: Short literals are zero-extended on the left, or extended with x or z when that leads.
*/
module top;
  logic [9:0] zero_pad, x_pad, z_pad;
  initial begin
    zero_pad = 10'h5;
    x_pad    = 10'bx1;
    z_pad    = 10'hz;
    if (zero_pad !== 10'b00_0000_0101) $display("FAIL: zero padding gave %b", zero_pad);
    else if (x_pad !== {9'bxxxxxxxxx, 1'b1}) $display("FAIL: x padding gave %b", x_pad);
    else if (z_pad !== {10{1'bz}}) $display("FAIL: z padding gave %b", z_pad);
    else $display("PASS");
    $finish;
  end
endmodule
