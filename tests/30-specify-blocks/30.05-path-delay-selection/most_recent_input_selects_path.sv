/*
:section: 30.5.3 Delay selection
:summary: Path delay is taken from active paths whose input changed most recently.
:flags-icarus: -gspecify
*/
module dut(input a, input b, output y);
  and g(y, a, b);
  specify
    (a => y) = (4, 10);
    (b => y) = (7, 12);
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
  logic a = 0, b = 0;
  wire y;
  dut u(.a(a), .b(b), .y(y));
  initial begin
    #20 a = 1;
    #20 b = 1;
    #6 check(y === 1'b0, "rise caused by b: not yet at 6");
    #2 check(y === 1'b1, "rise caused by b uses b's 7");
    #12 a = 0;
    #9 check(y === 1'b1, "fall caused by a: not yet at 9");
    #2 check(y === 1'b0, "fall caused by a uses a's 10");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
