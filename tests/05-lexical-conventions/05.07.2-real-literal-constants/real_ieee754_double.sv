/*
:section: 5.7.2 Real literal constants
:summary: Real literals are stored as IEEE 754 double-precision values, checked using
  $realtobits.
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
    check($realtobits(1.5) == 64'h3FF8_0000_0000_0000, "1.5 is not the IEEE 754 double 3ff8...");
    check($realtobits(0.1) == 64'h3FB9_9999_9999_999A, "0.1 is not the nearest IEEE 754 double");
    check($realtobits(-2.0) == 64'hC000_0000_0000_0000, "-2.0 encoding");
    check(0.1 + 0.2 != 0.3, "0.1 + 0.2 equals 0.3 exactly, so not double precision");
    check($shortrealtobits(shortreal'(0.5)) == 32'h3F00_0000, "shortreal cast of 0.5");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
