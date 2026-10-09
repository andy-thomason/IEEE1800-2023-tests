/*
:section: 9.2.2.4 Sequential logic always_ff procedure
:summary: An always_ff block must not contain a second event control.
:type: elaboration
:should_fail_because: always_ff contains a second event control
*/
module top;
  logic clk, d, q;
  always_ff @(posedge clk) begin
    q <= d;
    @(negedge clk) q <= ~d;
  end
endmodule
