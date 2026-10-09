/*
:section: 10.9.2 Structure assignment patterns
:summary: Every structure member must be covered by a member key, type key or default in an
  assignment pattern.
:type: elaboration
:should_fail_because: member c is not covered by any key
*/
module top;
  typedef struct { int a; int b; byte c; } s_t;
  s_t s;
  initial s = '{a: 1, int: 2};
endmodule
