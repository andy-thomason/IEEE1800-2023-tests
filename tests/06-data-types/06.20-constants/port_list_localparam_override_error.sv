/*
:section: 6.20.4 Local parameters (localparam)
:summary: Port-list parameters after a localparam keyword are local and cannot be overridden.
:type: elaboration
:should_fail_because: C follows the localparam keyword, so it is local
*/
module mixed #(parameter int A = 1, localparam int B = A * 2, C = 3);
endmodule

module top;
  mixed #(.C(7)) u();
endmodule
