/*
:section: 6.19 Enumerations
:summary: An enum value that does not fit in an unsigned base type is illegal.
:type: elaboration
:should_fail_because: 9 does not fit in 3 unsigned bits
*/
module top;
  typedef enum bit [2:0] {A = 9} e_t;
endmodule
