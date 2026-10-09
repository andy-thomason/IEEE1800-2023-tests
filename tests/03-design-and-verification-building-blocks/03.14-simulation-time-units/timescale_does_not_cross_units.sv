/*
:section: 3.14.2.1 The `timescale compiler directive
:summary: A `timescale in one compilation unit has no effect on design elements in another unit.
:description: With one compilation unit per file, the second file's module takes its unit from its
  own compilation-unit timeunit (1ns), not the first file's `timescale (1us).
:files: timescale_does_not_cross_units_probe.svh
:flags-icarus: -u
*/
`timescale 1us / 1us
module top;
  timeunit 1ps;
  timeprecision 1ps;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic d;
  other_unit_probe u(.done(d));
  initial begin
    @(posedge d) check($time == 4000, $sformatf("#4 in the second unit took %0d ps, expected 4000 (1ns from its own timeunit)", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
