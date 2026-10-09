/*
:section: 6.20.4 Local parameters (localparam)
:summary: A parameter inside a generate block is local, so defparam must not change it.
:type: elaboration
:should_fail_because: G is a localparam because it is in a generate block
*/
module holder;
  if (1) begin : gen
    parameter int G = 3;
  end
endmodule

module top;
  holder u();
  defparam u.gen.G = 5;
endmodule
