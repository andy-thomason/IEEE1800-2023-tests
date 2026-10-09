/*
:section: 30.5.2 Specifying x transition delays
:summary: Without explicit x delays, transitions to x use the shortest delay and from x the
  longest.
:flags-icarus: -gspecify
*/
module dut(input a, output y);
  buf b(y, a);
  specify
    // t01, t10, t0z, tz1, t1z, tz0
    (a => y) = (2, 4, 6, 8, 10, 12);
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
    #30 a = 1'bx;
    #1 check(y === 1'b0, "0->x not yet at 1");
    #2 check(y === 1'bx, "0->x uses min(t0z, t01) = 2");
    #27 a = 1;
    #7 check(y === 1'bx, "x->1 not yet at 7");
    #2 check(y === 1'b1, "x->1 uses max(tz1, t01) = 8");
    #21 a = 1'bx;
    #3 check(y === 1'b1, "1->x not yet at 3");
    #2 check(y === 1'bx, "1->x uses min(t1z, t10) = 4");
    #25 a = 0;
    #11 check(y === 1'bx, "x->0 not yet at 11");
    #2 check(y === 1'b0, "x->0 uses max(tz0, t10) = 12");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
