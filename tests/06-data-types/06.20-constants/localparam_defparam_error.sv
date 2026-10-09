/*
:section: 6.20.4 Local parameters (localparam)
:summary: A defparam statement must not modify a localparam.
:type: elaboration
:should_fail_because: defparam targets a localparam
*/
module holder;
  localparam int L = 3;
endmodule

module top;
  holder u();
  defparam u.L = 4;
endmodule
