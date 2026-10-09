/*
:section: 10.3.3 Continuous assignment delays
:summary: Continuous assignment delays pick rise, fall or turn-off values based on the direction
  of the transition.
*/
module top;
  int errors = 0;
  task automatic check(input bit ok, input string what);
    if (!ok) begin
      $display("FAIL: %s", what);
      errors++;
    end
  endtask
  logic [3:0] src = 4'd0;
  logic en = 1;
  wire [3:0] out;
  assign #(3, 5, 7) out = en ? src : 4'bz;
  initial begin
    #10 src = 4'd6;
    #2 check(out == 0, "rising delay too short");
    #1 check(out == 6, "rising delay of 3");
    #10 src = 4'd0;
    #4 check(out == 6, "falling delay too short");
    #1 check(out == 0, "falling delay of 5");
    #10 en = 0;
    #6 check(out == 0, "turn-off delay too short");
    #1 check(out === 4'bz, "turn-off delay of 7");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
