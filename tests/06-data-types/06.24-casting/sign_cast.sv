/*
:section: 6.24.1 Cast operator
:summary: signed' and unsigned' casts keep the bit pattern of the operand but change its
  signedness.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [7:0] u8;
  logic signed [7:0] s8;
  initial begin
    u8 = unsigned'(-6);
    check(u8 === 8'hFA, $sformatf("unsigned'(-6) into 8 bits = %h", u8));
    check(unsigned'(-6) > 0, "unsigned'(-6) is not unsigned");
    s8 = signed'(4'b1010);
    check(s8 == -6, $sformatf("signed'(4'b1010) widened = %0d", s8));
    check($bits(signed'(4'b1010)) == 4, "sign cast changed the width");
    check(signed'(4'b1010) === $signed(4'b1010) && unsigned'(4'sb1010) === $unsigned(4'sb1010), "$signed/$unsigned differ");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
