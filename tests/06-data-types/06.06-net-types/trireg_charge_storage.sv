/*
:section: 6.6.4 Trireg net
:summary: A trireg takes its driven value but keeps its last value when all drivers go to z.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic d = 1'b1, en = 1'b1;
  trireg store;
  bufif1 drv(store, d, en);
  initial begin
    #1 check(store === 1'b1, "driven 1");
    en = 1'b0;
    #1 check(store === 1'b1, "capacitive state did not hold 1");
    d = 1'b0; en = 1'b1;
    #1 check(store === 1'b0, "driven 0");
    en = 1'b0;
    #5 check(store === 1'b0, "capacitive state did not hold 0");
    d = 1'bx; en = 1'b1;
    #1 check(store === 1'bx, "driven x did not propagate");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
