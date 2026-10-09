/*
:section: 28.8 Bidirectional pass switches
:summary: tran and rtran switches may not have delay specifications.
:type: parse
:should_fail_because: a tran has a delay
*/
module top;
  wire a, b;
  tran #2 t(a, b);
endmodule
