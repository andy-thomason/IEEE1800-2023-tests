/*
:section: 28.8 Bidirectional pass switches
:summary: rtran terminals must connect to scalar nets or single bits of vectors, not whole
  vectors.
:type: elaboration
:should_fail_because: an rtran connects whole vectors
*/
module top;
  wire [3:0] a, b;
  rtran t(a, b);
endmodule
