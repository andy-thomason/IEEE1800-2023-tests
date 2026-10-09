/*
:section: 11.4.3 Arithmetic operators
:summary: The % operator yields all x bits whenever its divisor is zero.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [11:0] num, zero, r;
  integer s, sz, sr;
  initial begin
    num = 12'd77;
    zero = 12'd0;
    r = num % zero;  check(r === 12'hxxx, $sformatf("77 %% 0 = %b", r));
    r = zero % zero; check(r === 12'hxxx, $sformatf("0 %% 0 = %b", r));
    s = -77;
    sz = 0;
    sr = s % sz;     check(sr === 32'hxxxx_xxxx, $sformatf("signed -77 %% 0 = %b", sr));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
