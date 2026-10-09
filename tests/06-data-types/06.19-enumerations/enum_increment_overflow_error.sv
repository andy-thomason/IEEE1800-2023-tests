/*
:section: 6.19 Enumerations
:summary: Auto-incrementing past the largest value the enum base type can hold is an error.
:type: elaboration
:should_fail_because: B would be the increment of the maximum value 3
*/
module top;
  typedef enum bit [1:0] {A = 3, B} e_t;
endmodule
