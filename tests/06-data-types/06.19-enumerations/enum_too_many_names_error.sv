/*
:section: 6.19 Enumerations
:summary: An enum must not have more names than its base type width can encode.
:type: elaboration
:should_fail_because: three names need more than one bit
*/
module top;
  typedef enum bit [0:0] {A, B, C} e_t;
endmodule
