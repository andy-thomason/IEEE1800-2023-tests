/*
:section: 3.14.1 Time value rounding
:summary: When precision equals the time unit, delay values are rounded to integers.
*/
module whole_precision(output logic done_a, done_b);
  timeunit 1ns;
  timeprecision 1ns;
  initial begin
    done_a = 0;
    done_b = 0;
    #2.4 done_a = 1;   // 2ns
    #2.6 done_b = 1;   // 3ns, so 5ns in total
  end
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
  whole_precision u(.done_a(a), .done_b(b));
  initial begin
    @(posedge a) check($time == 2000, $sformatf("#2.4 at 1ns/1ns took %0d ps, expected 2000", $time));
    @(posedge b) check($time == 5000, $sformatf("#2.6 at 1ns/1ns ended at %0d ps, expected 5000", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
