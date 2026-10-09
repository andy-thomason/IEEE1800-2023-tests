/*
:section: 30.7.4.2 Negative pulse detection
:summary: With showcancelled and on-detect style, a negative pulse drives the output to x
  immediately.
:flags-icarus: -gspecify
*/
module dut(input a, output y);
  buf b(y, a);
  specify
    pulsestyle_ondetect y;
    showcancelled y;
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
  initial begin
    #20 a = 1;
    #1 a = 0;
    #1 check(y === 1'bx, $sformatf("negative pulse shown as x on detection, y=%b", y));
    #5 check(y === 1'b0, "back to 0 after the trailing edge time");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
