/*
:section: 7.8.5 Other user-defined types
:summary: An associative array index type cannot be or contain real or shortreal.
:type: elaboration
:should_fail_because: the index type contains a real member
*/
module top;
  typedef struct { int a; real r; } has_real_t;
  int bad [has_real_t];
endmodule
