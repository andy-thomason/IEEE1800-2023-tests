/*
:section: 6.19 Enumerations
:summary: A sized literal enum value must have exactly the same width as the enum base type.
:type: elaboration
:should_fail_because: a 3-bit sized literal is used with a 4-bit enum
*/
module top;
  typedef enum bit [3:0] {A = 3'd2, B} e_t;
endmodule
