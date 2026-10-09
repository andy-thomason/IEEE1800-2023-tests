/*
:section: 6.6.2 Unresolved nets
:summary: A uwire net must not have more than one driver on any bit.
:type: elaboration
:should_fail_because: the uwire net has two continuous drivers
*/
module top;
  logic p = 1'b0, q = 1'b1;
  uwire single;
  assign single = p;
  assign single = q;
endmodule
