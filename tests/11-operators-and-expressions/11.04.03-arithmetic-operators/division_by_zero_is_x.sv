/*
:section: 11.4.3 Arithmetic operators
:summary: Integer division or modulus by zero produces an all-x result.
:description: Division of 4-state operands by a zero divisor.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [15:0] num, zero, r;
  integer s, sz, sr;
  initial begin
    num = 16'd1234;
    zero = 16'd0;
    r = num / zero;  check(r === 16'hxxxx, $sformatf("1234 / 0 = %b", r));
    r = zero / zero; check(r === 16'hxxxx, $sformatf("0 / 0 = %b", r));
    s = -7;
    sz = 0;
    sr = s / sz;     check(sr === 32'hxxxx_xxxx, $sformatf("signed -7 / 0 = %b", sr));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
