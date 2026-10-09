/*
:section: 28.4 and, nand, nor, or, xor, and xnor gates
:summary: Logic gate delays: two values set rise and fall, one sets all, none means zero delay.
:description: Starts at 20 so the initial x-to-0 settling is out of the way. Delays are whole time
  units because fractional delays round to the time precision.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic a = 0, b = 1;
  wire y2, y1, y0;
  and #(4, 10) g2(y2, a, b);
  and #6 g1(y1, a, b);
  and g0(y0, a, b);
  initial begin
    #20 a = 1;
    #1 check(y0 === 1'b1 && y2 === 1'b0 && y1 === 1'b0, "no delay vs pending");
    #2 check(y2 === 1'b0, "not risen at 3");
    #2 check(y2 === 1'b1 && y1 === 1'b0, "rise delay 4");
    #2 check(y1 === 1'b1, "single delay 6");
    #13 a = 0;
    #9 check(y2 === 1'b1, "fall delay 10 not elapsed at 9");
    #2 check(y2 === 1'b0, "fall after 10");
    #9 a = 1;
    #9 a = 1'bx;
    #3 check(y2 === 1'b1, "not x at 3");
    #2 check(y2 === 1'bx, "transition to x uses the smaller delay (4)");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
