/*
:section: 6.9.1 Specifying vectors
:summary: Vector msb and lsb may be any integers, with msb on the left in either direction.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [-2:3] up;
  logic [5:-1] down;
  logic [3:0] wrap;
  logic [7:7] one;
  initial begin
    up = 6'b100000;
    check($bits(up) == 6 && up[-2] === 1'b1 && up[3] === 1'b0, "[-2:3]: msb is index -2");
    down = 7'b0000001;
    check($bits(down) == 7 && down[-1] === 1'b1, "[5:-1]: lsb is index -1");
    check($bits(one) == 1, "[7:7] is one bit");
    wrap = 4'd15;
    wrap = wrap + 1;
    check(wrap == 0, "4-bit arithmetic is not modulo 16");
    wrap = 4'd0 - 4'd1;
    check(wrap == 15, "4-bit subtraction is not modulo 16");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
