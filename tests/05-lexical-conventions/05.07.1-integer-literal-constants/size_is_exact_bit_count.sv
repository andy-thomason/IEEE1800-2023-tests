/*
:section: 5.7.1 Integer literal constants
:summary: The size prefix of a literal fixes its exact width in bits, as $bits confirms.
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
    check($bits(5'd3) == 5, "$bits(5'd3)");
    check($bits(13'h1) == 13, "$bits(13'h1)");
    check($bits(1'b1) == 1, "$bits(1'b1)");
    check($bits(70'o0) == 70, "$bits(70'o0)");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
