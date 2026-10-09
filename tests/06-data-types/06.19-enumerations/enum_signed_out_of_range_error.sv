/*
:section: 6.19 Enumerations
:summary: A signed enum value that cannot fit in the base type without changing sign is illegal.
:type: elaboration
:should_fail_because: 4 does not fit in 3 signed bits
*/
module top;
  typedef enum logic signed [2:0] {A = 4} e_t;
endmodule
