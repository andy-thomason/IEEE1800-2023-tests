/*
:section: 5.8 Time literals
:summary: A time literal is a realtime value converted into the time unit of the enclosing
  scope.
*/
module in_ns(output logic done);
  timeunit 1ns;
  timeprecision 1ps;
  realtime as_value = 2.5us;
  initial begin
    done = 0;
    #1.5ns;
    #250ps;
    done = 1;
  end
endmodule

module in_100ps;
  timeunit 100ps;
  timeprecision 1ps;
  realtime one_ns = 1ns;
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
  in_ns u_ns(.done(d));
  in_100ps u_100ps();
  initial begin
    @(posedge d) check($time == 1750, $sformatf("#1.5ns then #250ps took %0d ps, expected 1750", $time));
    check(u_ns.as_value == 2500.0, $sformatf("2.5us in a 1ns module = %f, expected 2500", u_ns.as_value));
    check(u_100ps.one_ns == 10.0, $sformatf("1ns in a 100ps module = %f, expected 10", u_100ps.one_ns));
    check(1ns == 1000.0, "1ns in a 1ps module is not 1000");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
