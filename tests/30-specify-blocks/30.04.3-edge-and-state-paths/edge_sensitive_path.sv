/*
:section: 30.4.3 Edge-sensitive paths
:summary: A posedge-qualified path with a data source expression applies its delay on the clock
  edge.
:flags-icarus: -gspecify
*/
module flop(input clk, input d, output reg q);
  always @(posedge clk) q <= d;
  specify
    (posedge clk => (q : d)) = 4;
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
  logic clk = 0, d = 1;
  wire q;
  flop u(.clk(clk), .d(d), .q(q));
  initial begin
    #20 clk = 1;
    #3 check(q !== 1'b1, "not updated at 3");
    #2 check(q === 1'b1, "posedge path delay 4");
    if (errors == 0) $display("PASS");
    $finish;
  end
endmodule
