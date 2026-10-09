/*
:section: 35.5.2 Pure functions
:summary: A pure DPI import must be non-void with only inputs, and its result depends solely on
  inputs.
:dpi: pure_function.c
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  import "DPI-C" pure function real sqrt(input real x);
  import "DPI-C" pure function int gcd(input int a, input int b);
  initial begin
    check(sqrt(81.0) == 9.0, "pure import of the C library sqrt");
    check(gcd(84, 36) == 12, "pure user function");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
