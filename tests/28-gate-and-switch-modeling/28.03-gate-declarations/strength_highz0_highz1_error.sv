/*
:section: 28.3.2 The drive strength specification
:summary: The drive strength pair (highz0, highz1) is invalid for a gate.
:type: parse
:should_fail_because: a gate has strength (highz0, highz1)
*/
module top;
  logic a;
  wire o;
  buf (highz0, highz1) g(o, a);
endmodule
