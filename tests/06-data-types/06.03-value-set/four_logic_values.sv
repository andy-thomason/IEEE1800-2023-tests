/*
:section: 6.3.1 Logic values
:summary: The value set has 0, 1, x and z, and z inputs usually act like x in gates and
  expressions.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] v = 4'b01xz;
  logic zbit = 1'bz, one = 1'b1, on = 1'b1;
  wire and_out, nmos_out;
  and g(and_out, zbit, one);
  nmos m(nmos_out, zbit, on);
  initial begin
    #1;
    check(v[3] === 1'b0 && v[2] === 1'b1 && v[1] === 1'bx && v[0] === 1'bz, "each bit holds its own value");
    check((zbit & one) === 1'bx, "z & 1 in an expression is not x");
    check((zbit | one) === 1'b1, "z | 1 is not 1");
    check(and_out === 1'bx, $sformatf("and gate with a z input = %b, expected x", and_out));
    check(nmos_out === 1'bz, $sformatf("nmos passing z = %b, expected z", nmos_out));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
