/*
:section: 10.3.3 Continuous assignment delays
:summary: With continuous assignment delays, a newer right-hand value cancels an older pending
  value before it propagates.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic d = 0;
  wire q;
  int changes = 0;
  assign #5 q = d;
  always @(q) changes++;
  initial begin
    #10;
    changes = 0;
    d = 1;
    #2 d = 0;
    #10;
    check(changes == 0 && q === 1'b0, $sformatf("a 2-unit pulse through a 5-unit delay produced %0d changes", changes));
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
