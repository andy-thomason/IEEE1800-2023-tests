/*
:section: 20.9 Bit vector system functions
:summary: $countbits counts bits matching any listed control value, using only the LSB of each
  control argument.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:0] v = 8'b1x0z_1100;
  logic ctl = 1'bz;
  initial begin
    check($countbits(v, '1) == 3, "count of ones");
    check($countbits(v, '1, '0) == 6, "count of ones and zeros");
    check($countbits(v, 'x, 'z) == 2 && $countbits(v, ctl) == 1, "x/z and a variable control bit");
    check($countbits(v, 2'b10) == 3, "only the LSB of a wide control bit is used");
    check($countbits(v, '1, '1) == 3, "duplicate control bits");
    check($onehot(8'b0001_0000) && !$onehot(8'b0) && $onehot0(8'b0) && !$onehot0(8'b11), "$onehot / $onehot0");
    check($isunknown(v) && !$isunknown(8'hA5), "$isunknown");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
