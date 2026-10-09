/*
:section: 3.14.2.1 The `timescale compiler directive
:summary: A design element with its own timeunit and timeprecision ignores any preceding
  `timescale.
*/
`timescale 1ns / 1ns
module own_units(output logic done);
  timeunit 1us;
  timeprecision 1us;
  initial begin done = 0; #2 done = 1; end
endmodule

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
  own_units u(.done(d));
  initial begin
    @(posedge d) check($time == 2_000_000, $sformatf("#2 took %0d ps, expected 2000000 (1us units)", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
