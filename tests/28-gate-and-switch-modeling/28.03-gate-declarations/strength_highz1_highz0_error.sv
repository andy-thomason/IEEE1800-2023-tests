/*
:section: 28.3.2 The drive strength specification
:summary: The drive strength pair (highz1, highz0) is invalid for a gate.
:type: parse
:should_fail_because: a gate has strength (highz1, highz0)
*/
module top;
  logic a;
  wire o;
  buf (highz1, highz0) g(o, a);
endmodule
