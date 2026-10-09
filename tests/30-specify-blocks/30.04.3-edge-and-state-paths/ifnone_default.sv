/*
:section: 30.4.4.4 The ifnone condition
:summary: An ifnone path supplies the delay used when no conditional path for that connection is
  true.
:flags-icarus: -gspecify
*/
module dut(input a, input c, output y);
  buf b(y, a);
  specify
    if (c) (a => y) = 3;
    ifnone (a => y) = 9;
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
  logic a = 0, c = 1;
  wire y;
  dut u(.a(a), .c(c), .y(y));
  initial begin
    #20 a = 1;
    #4 check(y === 1'b1, "condition true: delay 3");
    c = 0;
    #16 a = 0;
    #8 check(y === 1'b1, "ifnone: not changed at 8");
    #2 check(y === 1'b0, "ifnone delay 9");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
