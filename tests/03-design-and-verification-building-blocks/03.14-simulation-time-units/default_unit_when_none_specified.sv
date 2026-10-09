/*
:section: 3.14.2.3 Precedence of timeunit, timeprecision, and `timescale
:summary: Without any timeunit or `timescale, all design elements use the same
  implementation-defined default time unit.
:description: No element specifies a unit, so all share the default and #5 reads back as 5.
*/
module delayer(output logic done);
  initial begin done = 0; #5 done = 1; end
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic d;
  delayer u(.done(d));
  initial begin
    @(posedge d) check($time == 5, $sformatf("#5 in the same default units ended at %0d", $time));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
