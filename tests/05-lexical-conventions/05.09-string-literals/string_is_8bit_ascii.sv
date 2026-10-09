/*
:section: 5.9 String literals
:summary: String literals in expressions act as unsigned numbers, each character occupying one
  ASCII byte.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  bit [23:0] three = "Ok!";
  bit [7:0] newline = "\n";
  initial begin
    check(three === 24'h4F6B21, $sformatf("\"Ok!\" = %h", three));
    check(newline === 8'd10, $sformatf("\"\\n\" = %0d", newline));
    check($bits("abcde") == 40, $sformatf("$bits(\"abcde\") = %0d", $bits("abcde")));
    check($bits("a\tb") == 24, "an escape sequence is not one 8-bit character");
    check(("B" - "A") == 1, "string operands are not integer constants");
    check(!("Z" < 0), "a string literal is not unsigned");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
