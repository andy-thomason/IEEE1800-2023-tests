/*
:section: 30.5.3 Delay selection
:summary: When several conditional paths are active together, the smallest applicable delay is
  used.
:flags-icarus: -gspecify
*/
module dut(input a, input [2:0] sel, output y);
  buf b(y, a);
  specify
    if (sel[0]) (a => y) = (8, 2);
    if (sel[1]) (a => y) = (4, 7);
    if (sel[2]) (a => y) = (1, 1);
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
  logic [2:0] sel = 3'b011;
  wire y;
  dut u(.a(a), .sel(sel), .y(y));
  initial begin
    #20 a = 1;
    #3 check(y === 1'b0, "rise not yet at 3");
    #2 check(y === 1'b1, "rise uses min(8, 4) = 4");
    #15 a = 0;
    #1 check(y === 1'b1, "fall not yet at 1");
    #2 check(y === 1'b0, "fall uses min(2, 7) = 2");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
