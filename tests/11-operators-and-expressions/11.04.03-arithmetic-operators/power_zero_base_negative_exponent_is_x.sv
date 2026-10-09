/*
:section: 11.4.3 Arithmetic operators
:summary: Raising zero to a negative power with ** gives an x result.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  integer zero, e, r;
  int zero2, e2;
  initial begin
    zero = 0;
    e = -1; r = zero ** e;   check(r === 32'hxxxx_xxxx, $sformatf("0 ** -1 = %b", r));
    e = -2; r = zero ** e;   check(r === 32'hxxxx_xxxx, $sformatf("0 ** -2 = %b", r));
    zero2 = 0;
    e2 = -9; r = zero2 ** e2; check(r === 32'hxxxx_xxxx, $sformatf("2-state 0 ** -9 = %b", r));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
