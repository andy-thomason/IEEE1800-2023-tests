/*
:section: 6.19 Enumerations
:summary: A 2-state enum must not assign x or z to any of its names.
:type: elaboration
:should_fail_because: a 2-state enum has an x value
*/
module top;
  typedef enum bit [1:0] {A, B = 'x, C = 2} e_t;
endmodule
