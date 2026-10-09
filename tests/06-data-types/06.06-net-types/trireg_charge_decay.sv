/*
:section: 6.6.4.2 Ideal capacitive state and charge decay
:summary: A trireg delay specification sets its charge decay time; without one the stored value
  persists.
:description: Charge decay to x is detailed in 28.16.2.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic en = 1'b1;
  trireg #(0, 0, 50) leaky;
  trireg keeps;
  bufif1 d1(leaky, 1'b1, en);
  bufif1 d2(keeps, 1'b1, en);
  initial begin
    #10 en = 1'b0;
    #45 check(leaky === 1'b1, "charge decayed before the decay time");
    #10 check(leaky === 1'bx, $sformatf("charge has not decayed after the decay time: %b", leaky));
    check(keeps === 1'b1, "a trireg without a decay time lost its charge");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
