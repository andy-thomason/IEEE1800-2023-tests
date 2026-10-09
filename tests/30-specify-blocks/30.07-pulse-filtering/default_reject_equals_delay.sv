/*
:section: 30.7 Detailed control of pulse filtering behavior
:summary: By default the reject and error limits equal the path delay, so shorter pulses are
  swallowed.
:flags-icarus: -gspecify
*/
module dut(input a, output y);
  buf b(y, a);
  specify
    (a => y) = 5;
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
  bit saw_one;
  always @(y) if (y === 1'b1) saw_one = 1;
  initial begin
    #20 a = 1;
    #3 a = 0;
    #20 check(!saw_one, "a 3-unit pulse through a 5-unit path was not rejected");
    a = 1;
    #6 a = 0;
    #1 check(y === 1'b1, "a 6-unit pulse passes");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
