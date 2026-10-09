/*
:section: 6.20.2 Value parameters
:summary: An untyped, unranged parameter takes its width from its final value, with
  integer-sized defaults.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  parameter SIZED = 3'h5;
  parameter UNSIZED = 6;
  parameter int ROUNDED = 2.5;
  parameter [15:0] PATTERN = 16'hA5C3;
  initial begin
    check($bits(SIZED) == 3, $sformatf("$bits(SIZED) = %0d", $bits(SIZED)));
    check($bits(UNSIZED) >= 32, $sformatf("$bits(UNSIZED) = %0d", $bits(UNSIZED)));
    check(ROUNDED == 3, $sformatf("int parameter from 2.5 = %0d", ROUNDED));
    check(PATTERN[3:0] == 4'h3 && PATTERN[15] == 1'b1, "part- and bit-select of a parameter");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
