/*
:section: 3.14.2.3 Precedence of timeunit, timeprecision, and `timescale
:summary: Modules without their own timeunit or timeprecision take the values declared at
  compilation-unit scope.
*/
timeunit 100ns;
timeprecision 10ns;

module inherits_unit(output logic done_a, done_b);
  initial begin
    done_a = 0;
    done_b = 0;
    #1 done_a = 1;       // 100ns
    #0.123 done_b = 1;   // 12.3ns rounds to 10ns at 10ns precision
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
  inherits_unit u(.done_a(a), .done_b(b));
  initial begin
    @(posedge a) check($time == 100_000, $sformatf("#1 took %0d ps, expected 100000", $time));
    @(posedge b) check($time == 110_000, $sformatf("#0.123 ended at %0d ps, expected 110000", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
