/*
:section: 6.6.2 Unresolved nets
:summary: A uwire net must not connect to a terminal of a bidirectional tran switch.
:type: elaboration
:should_fail_because: a uwire net is connected to a tran switch
*/
module top;
  uwire single;
  wire other;
  tran t(single, other);
endmodule
