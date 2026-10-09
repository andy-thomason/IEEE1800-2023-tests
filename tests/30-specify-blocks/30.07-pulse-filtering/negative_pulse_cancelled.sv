/*
:section: 30.7.4.2 Negative pulse detection
:summary: If a pulse trailing edge is scheduled before its leading edge, both are cancelled and
  no output change occurs.
:flags-icarus: -gspecify
*/
module dut(input a, output y);
  buf b(y, a);
  specify
    (a => y) = (6, 3);
  endspecify
endmodule

module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a = 0;
  wire y;
  dut u(.a(a), .y(y));
  bit changed;
  always @(y) if ($time > 15) changed = 1;
  initial begin
    #20 a = 1;
    #1 a = 0;
    #20 check(!changed && y === 1'b0, "the cancelled leading edge produced a transition");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
