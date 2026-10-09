/*
:section: 6.20.4 Local parameters (localparam)
:summary: An instance parameter assignment must not override a localparam.
:type: elaboration
:should_fail_because: an instance tries to override a localparam
*/
module holder;
  localparam int L = 3;
endmodule

module top;
  holder #(.L(4)) u();
endmodule
