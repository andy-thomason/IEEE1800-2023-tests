/*
:section: 11.4.6 Wildcard equality operators
:summary: The ==? and !=? operators treat x and z bits in the right operand as matching
  anything.
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
    v = 4'b1011;
    check((v ==? 4'b1x1z) === 1'b1, "x and z in the right operand are wildcards");
    check((v ==? 4'b0x1z) === 1'b0, "a known bit differs");
    check((v !=? 4'b0xxx) === 1'b1, "!=?");
    v = 4'b1x11;
    check((v ==? 4'b1011) === 1'bx, "x in the left operand is not a wildcard");
    check((v ==? 4'b1?11) === 1'b1, "? is a wildcard on the right");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
