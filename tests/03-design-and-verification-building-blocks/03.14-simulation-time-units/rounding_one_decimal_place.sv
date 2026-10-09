/*
:section: 3.14.1 Time value rounding
:summary: With precision one tenth of the time unit, delays are rounded to a single decimal
  digit.
*/
module tenth_precision(output logic done_a, done_b);
  timeunit 1ns;
  timeprecision 100ps;
  initial begin
    done_a = 0;
    done_b = 0;
    #3.14 done_a = 1;   // 3.1ns
    #0.06 done_b = 1;   // rounds to 0.1ns, so 3.2ns in total
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
  tenth_precision u(.done_a(a), .done_b(b));
  initial begin
    @(posedge a) check($time == 3100, $sformatf("#3.14 at 1ns/100ps took %0d ps, expected 3100", $time));
    @(posedge b) check($time == 3200, $sformatf("#0.06 at 1ns/100ps ended at %0d ps, expected 3200", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
