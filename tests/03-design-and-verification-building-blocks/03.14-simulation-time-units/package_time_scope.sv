/*
:section: 3.14.2.2 The timeunit and timeprecision keywords
:summary: A package can set its own timeunit and timeprecision, which govern delays inside its
  tasks.
:description: A package is its own time scope: delays in its task use the package's time unit.
*/
package slow_timing;
  timeunit 1us;
  timeprecision 1ns;
  task automatic wait_one();
    #1;
  endtask
endpackage

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
  initial begin
    slow_timing::wait_one();
    check($time == 1_000_000, $sformatf("package task #1 took %0d ps, expected 1000000", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
