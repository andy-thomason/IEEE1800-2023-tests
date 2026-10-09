/*
:section: 3.14.2.2 The timeunit and timeprecision keywords
:summary: Repeating timeunit and timeprecision later in a scope is allowed when the values agree
  with earlier ones.
*/
module top;
  timeunit 1ns;
  timeprecision 1ps;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic flag = 0;
  timeunit 1ns;
  timeprecision 1ps;
  initial begin
    #1.5;
    check($realtime == 1.5, $sformatf("$realtime = %f, expected 1.5", $realtime));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
