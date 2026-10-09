/*
:section: 11.4.14 Streaming operators (pack/unpack)
:summary: Assigning a stream to a fixed-size target narrower than that stream is an error.
:type: elaboration
:should_fail_because: a 16-bit stream is assigned to an 8-bit variable
*/
module top;
  logic [7:0] r;
  initial r = {>> {16'hABCD}};
endmodule
