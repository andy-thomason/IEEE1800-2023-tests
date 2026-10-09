/*
:section: 28.5 buf and not gates
:summary: buf and not gates accept at most two delays; three is illegal.
:type: elaboration
:should_fail_because: a buf gate has three delays
*/
module top;
  logic a;
  wire y;
  buf #(1, 2, 3) g(y, a);
endmodule
