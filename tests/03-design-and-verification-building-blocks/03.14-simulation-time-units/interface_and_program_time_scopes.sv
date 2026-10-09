/*
:section: 3.14.2.2 The timeunit and timeprecision keywords
:summary: Interfaces and programs may each declare their own timeunit and timeprecision, forming
  separate time scopes.
*/
interface slow_if;
  timeunit 10ns;
  timeprecision 1ns;
  logic done = 0;
  initial #2 done = 1;     // 20ns
endinterface

program fast_prog(output logic done);
  timeunit 100ps;
  timeprecision 1ps;
  initial begin done = 0; #7 done = 1; end   // 700ps
endprogram

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
  logic p;
  slow_if u_if();
  fast_prog u_prog(.done(p));
  initial begin
    @(posedge p) check($time == 700, $sformatf("program #7 took %0d ps, expected 700", $time));
    @(posedge u_if.done) check($time == 20_000, $sformatf("interface #2 ended at %0d ps, expected 20000", $time));
    #1;
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
