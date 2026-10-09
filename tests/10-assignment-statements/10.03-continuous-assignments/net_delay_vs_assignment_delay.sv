/*
:section: 10.3.3 Continuous assignment delays
:summary: A net delay applies to every driver of the net, unlike a delay on the declaration
  assignment itself.
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
  wire #4 net_delayed;
  assign #2 net_delayed = d;
  wire #3 decl_delayed = d;
  initial begin
    #10 d = 1;
    #5 check(net_delayed === 1'b0, "net delay and assignment delay are not added");
    #1 check(net_delayed === 1'b1, "net delay plus assignment delay is 6");
    check(decl_delayed === 1'b1, "declaration assignment delay");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
