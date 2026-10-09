/*
:section: 3.14.1 Time value rounding
:summary: Each design element rounds its delays to its own precision, regardless of finer
  precision elsewhere.
*/
module coarse(output logic done);
  timeunit 10ns;
  timeprecision 1ns;
  initial begin
    done = 0;
    #1.26 done = 1;   // 12.6ns rounds to 13ns despite finer precision elsewhere
  end
endmodule

module top;
  timeunit 1fs;
  timeprecision 1fs;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic d;
  coarse u(.done(d));
  initial begin
    @(posedge d) check($time == 64'd13_000_000, $sformatf("#1.26 at 10ns/1ns took %0d fs, expected 13000000", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
