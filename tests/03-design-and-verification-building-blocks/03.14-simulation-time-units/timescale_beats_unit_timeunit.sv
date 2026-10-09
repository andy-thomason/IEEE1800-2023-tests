/*
:section: 3.14.2.3 Precedence of timeunit, timeprecision, and `timescale
:summary: A previous `timescale takes priority over a compilation-unit timeunit for modules
  lacking their own declaration.
*/
timeunit 100ns;
timeprecision 1ns;

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
  after_timescale u(.done(d));
  initial begin
    @(posedge d) check($time == 2_000_000, $sformatf("#2 took %0d ps, expected 2000000 (1us from `timescale)", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule

`timescale 1us / 1ns
module after_timescale(output logic done);
  initial begin done = 0; #2 done = 1; end
endmodule
