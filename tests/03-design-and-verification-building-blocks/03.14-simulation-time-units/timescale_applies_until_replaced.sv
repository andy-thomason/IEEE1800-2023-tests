/*
:section: 3.14.2.1 The `timescale compiler directive
:summary: A `timescale governs following design elements until another `timescale replaces it.
*/
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
  logic a, b, c;
  first_ns u_a(.done(a));
  second_ns u_b(.done(b));
  third_us u_c(.done(c));
  initial begin
    @(posedge a) check($time == 2000, $sformatf("first module #2 took %0d ps, expected 2000", $time));
    @(posedge b) check($time == 5000, $sformatf("second module #5 ended at %0d ps, expected 5000", $time));
    @(posedge c) check($time == 3_000_000, $sformatf("third module #3 ended at %0d ps, expected 3000000", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule

`timescale 1ns / 1ns
module first_ns(output logic done);
  initial begin done = 0; #2 done = 1; end
endmodule

module second_ns(output logic done);
  initial begin done = 0; #5 done = 1; end
endmodule

`timescale 1us / 1us
module third_us(output logic done);
  initial begin done = 0; #3 done = 1; end
endmodule
