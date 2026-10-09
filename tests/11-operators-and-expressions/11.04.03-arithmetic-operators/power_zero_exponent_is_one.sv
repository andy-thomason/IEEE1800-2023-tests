/*
:section: 11.4.3 Arithmetic operators
:summary: Any integral value raised to the power zero with ** evaluates to 1.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  int zero, base;
  logic [7:0] u8, r8;
  longint big;
  initial begin
    zero = 0;
    base = -5; check(base ** zero == 1, $sformatf("-5 ** 0 = %0d", base ** zero));
    base = -1; check(base ** zero == 1, $sformatf("-1 ** 0 = %0d", base ** zero));
    base = 0;  check(base ** zero == 1, $sformatf("0 ** 0 = %0d", base ** zero));
    base = 1;  check(base ** zero == 1, $sformatf("1 ** 0 = %0d", base ** zero));
    base = 7;  check(base ** zero == 1, $sformatf("7 ** 0 = %0d", base ** zero));
    u8 = 8'd200;
    r8 = u8 ** 8'd0; check(r8 == 8'd1, $sformatf("8'd200 ** 8'd0 = %0d", r8));
    big = 64'sd1 << 40;
    check(big ** zero == 64'sd1, "2**40 ** 0 is not 1");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
