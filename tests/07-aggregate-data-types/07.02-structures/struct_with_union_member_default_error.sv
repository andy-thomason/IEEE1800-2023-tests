/*
:section: 7.2.2 Assigning to structures
:summary: Default member values are not allowed in an unpacked struct that contains a union.
:type: elaboration
:should_fail_because: a struct that contains a union gives a member a default value
*/
module top;
  typedef struct { union { int i; bit [31:0] b; } u; int count = 3; } s_t;
endmodule
