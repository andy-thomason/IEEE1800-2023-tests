/*
:section: 7.2.1 Packed structures
:summary: A packed structure cannot contain a real member.
:type: elaboration
:should_fail_because: a packed struct contains a real member
*/
module top;
  struct packed { bit [7:0] a; real r; } p;
endmodule
