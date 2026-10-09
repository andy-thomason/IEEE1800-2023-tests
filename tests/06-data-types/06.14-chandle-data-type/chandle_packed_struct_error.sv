/*
:section: 6.14 Chandle data type
:summary: A chandle must not be a member of a packed struct.
:type: elaboration
:should_fail_because: a chandle is a member of a packed struct
*/
module top;
  typedef struct packed { chandle h; } s_t;
  s_t s;
endmodule
