/*
:section: 3.14.3 Simulation time unit
:summary: The simulation time unit equals the finest precision anywhere in the design, so tiny
  delays still resolve.
:description: The top module's precision is 1ns, but the 1fs precision elsewhere must still keep
  events 1fs apart in order.
*/
module femto_delay(output logic done);
  timeunit 1ps;
  timeprecision 1fs;
  parameter real DELAY = 0.0;
  initial begin done = 0; #DELAY done = 1; end
endmodule

module top;
  timeunit 1ns;
  timeprecision 1ns;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic at2, at3, at4;
  femto_delay #(.DELAY(0.002)) u2(.done(at2));
  femto_delay #(.DELAY(0.003)) u3(.done(at3));
  femto_delay #(.DELAY(0.004)) u4(.done(at4));
  initial begin
    @(posedge at3);
    check(at2 === 1'b1, "the 2fs event had not happened when the 3fs event fired");
    check(at4 === 1'b0, "the 4fs event had already happened when the 3fs event fired");
    #1;
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
