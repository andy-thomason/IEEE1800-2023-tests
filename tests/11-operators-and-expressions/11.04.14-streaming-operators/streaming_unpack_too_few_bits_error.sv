/*
:section: 11.4.14.3 Streaming concatenation as an assignment target (unpack)
:summary: Unpacking a stream is illegal when the source supplies fewer bits than the targets
  require.
:type: elaboration
:should_fail_because: an 8-bit source is unpacked into 16 bits of targets
*/
module top;
  byte a, b;
  initial {>> {a, b}} = 8'h12;
endmodule
