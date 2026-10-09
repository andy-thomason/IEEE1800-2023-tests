/*
:section: 9.2.2.2.2 always_comb compared to always @*
:summary: An always_comb block must not contain a delay control.
:type: elaboration
:should_fail_because: always_comb contains a delay
*/
module top;
  logic a, y;
  always_comb begin
    #1 y = a;
  end
endmodule
