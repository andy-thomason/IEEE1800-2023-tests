/*
:section: 7.3.1 Packed unions
:summary: A packed union may contain only integral members, so real is illegal.
:type: elaboration
:should_fail_because: a packed union contains a real member
*/
module top;
  union packed { bit [63:0] bits; real r; } u;
endmodule
