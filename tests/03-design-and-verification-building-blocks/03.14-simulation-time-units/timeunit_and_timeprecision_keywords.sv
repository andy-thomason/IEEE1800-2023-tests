/*
:section: 3.14.2.2 The timeunit and timeprecision keywords
:summary: Time unit and precision may be given with separate keywords or as timeunit unit /
  precision.
*/
module separate_keywords(output logic done);
  timeunit 100ps;
  timeprecision 1ps;
  initial begin done = 0; #3.25 done = 1; end   // 325ps
endmodule

module slash_form(output logic done);
  timeunit 10us / 1ns;
  initial begin done = 0; #0.5 done = 1; end    // 5us
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
  logic a, b;
  separate_keywords u_a(.done(a));
  slash_form u_b(.done(b));
  initial begin
    @(posedge a) check($time == 325, $sformatf("#3.25 at 100ps/1ps took %0d ps, expected 325", $time));
    @(posedge b) check($time == 5_000_000, $sformatf("#0.5 at 10us/1ns took %0d ps, expected 5000000", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
