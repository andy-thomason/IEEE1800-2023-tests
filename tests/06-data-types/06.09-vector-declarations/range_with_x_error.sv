/*
:section: 6.9.1 Specifying vectors
:summary: Vector range bounds must not contain x or z bits.
:type: elaboration
:should_fail_because: the msb expression contains an x bit
*/
module top;
  logic [4'b1x00:0] v;
endmodule
