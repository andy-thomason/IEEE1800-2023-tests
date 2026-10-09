/*
:section: 5.7.1 Integer literal constants
:summary: Base letters, the signed s marker, and hex digit letters are all case insensitive.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  initial begin
    check(8'D200 == 8'd200, "'D");
    check(8'HaB == 8'hAb && 8'hAB == 8'hab, "'H and hex digit case");
    check(9'O777 == 9'o777, "'O");
    check(4'B1001 == 4'b1001, "'B");
    check(4'SB1001 === 4'sb1001 && 4'Sb1001 < 0, "'S and 's");
    check(4'bX0Z1 === 4'bx0z1, "x and z case");
    check(8'hFx === 8'hfX, "hex x case");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
