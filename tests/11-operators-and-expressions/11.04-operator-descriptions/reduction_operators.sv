/*
:section: 11.4.9 Reduction operators
:summary: Reduction operators fold all bits of one operand into a single-bit result, propagating
  unknown values appropriately.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] v;
  initial begin
    v = 4'b1111;  check(&v === 1'b1 && ~&v === 1'b0, "and / nand");
    v = 4'b1101;  check(&v === 1'b0 && |v === 1'b1 && ^v === 1'b1 && ~^v === 1'b0, "mixed bits");
    v = 4'b0000;  check(|v === 1'b0 && ~|v === 1'b1, "or / nor");
    v = 4'b1x11;  check(&v === 1'bx && |v === 1'b1 && ^v === 1'bx, "with an x bit");
    v = 4'b0x00;  check(&v === 1'b0 && |v === 1'bx, "x with zeros");
    check($bits(^v) == 1, "the result is one bit");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
