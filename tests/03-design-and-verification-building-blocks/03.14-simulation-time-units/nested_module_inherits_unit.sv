/*
:section: 3.14.2.3 Precedence of timeunit, timeprecision, and `timescale
:summary: A nested module lacking its own timeunit takes the time unit of the module enclosing
  it.
:description: The nested module inherits 1us from its parent rather than taking 1ns from the earlier
  `timescale.
*/
`timescale 1ns / 1ns
module outer(output logic done);
  timeunit 1us;
  timeprecision 1ns;
  module inner(output logic done);
    initial begin done = 0; #3 done = 1; end   // 3us, inherited from outer
  endmodule
  inner u_inner(.done(done));
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
  outer u_outer(.done(d));
  initial begin
    @(posedge d) check($time == 3_000_000, $sformatf("nested #3 took %0d ps, expected 3000000", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
