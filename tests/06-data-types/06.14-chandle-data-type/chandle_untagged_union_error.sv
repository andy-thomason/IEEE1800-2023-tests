/*
:section: 6.14 Chandle data type
:summary: A chandle must not be a member of an untagged union.
:type: elaboration
:should_fail_because: a chandle is a member of an untagged union
*/
module top;
  typedef union { chandle h; int i; } u_t;
  u_t u;
endmodule
